import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hemocentro1/LoginDonator.dart';
import 'package:hemocentro1/LoginHemocenter.dart';
import 'package:hemocentro1/RegisterDonate.dart';
import 'package:hemocentro1/RegisterHemocenter.dart';
import 'package:hemocentro1/hemoData.dart';
import 'package:hemocentro1/main.dart';

import 'services/remote_service.dart';
import 'models/post.dart';
import 'shared/libs.dart';
import 'shared/constants.dart';
import 'package:hemocentro1/firebase_options.dart';

final databaseReference = FirebaseDatabase.instance.reference();
bool valido = false;
int flag = 0;

class DonatorData {
  final String email;
  final String nome;
  final String sexo;
  final String idade;
  final String senha;
  final String endereco;
  final String cpf;
  final String peso;
  final String tipoSangue;
  final String substancias;
  final DateTime data;

  DonatorData({
    required this.email,
    required this.nome,
    required this.sexo,
    required this.idade,
    required this.senha,
    required this.endereco,
    required this.cpf,
    required this.peso,
    required this.tipoSangue,
    required this.substancias,
    required this.data,
  });
}

void validateData(DonatorData userData, BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userdonate');

  if (int.parse(userData.idade) > 69 || int.parse(userData.idade) < 16)
  {
    valido = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('A sua idade deve ser entre 16 e 69 para realiar uma doação.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  else if (int.parse(userData.peso) < 50)
  {
    valido = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Você tem que pesar mais de 50kg para poder realizar uma doação'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  else if (userData.substancias == "Sim")
  {
    valido = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Você não pode usar substâncias ilícitas para realizar uma doação.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  else if ((userData.cpf).length <= 13)
  {
    valido = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Está faltando digitos no CPF.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  else
    {
      valido = true;
    }
}

void saveUserDonatorData(DonatorData userData, BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userdonate');

  validateData(userData, context);

  if (userData.nome != "" &&
      userData.email != "" &&
      userData.sexo != "" &&
      userData.idade != "" &&
      userData.senha != "" &&
      userData.endereco != "" &&
      userData.cpf != "" &&
      userData.peso != "" && valido == true) {
    try {
      await usersCollection.add({
        'nome': userData.nome,
        'email': userData.email,
        'sexo': userData.sexo,
        'idade': userData.idade,
        'senha': userData.senha,
        'endereço': userData.endereco,
        'cpf': userData.cpf,
        'peso': userData.peso,
        'tipo_sanguineo': userData.tipoSangue,
        'substancias': userData.substancias,
        'data': userData.data,
      });

      print('Dados do usuário doador salvos com sucesso.');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginDonator(donatorData: userData)));
    } catch (error) {
      print('Erro ao salvar os dados do usuário doador: $error');
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Algum campo foi deixado vazio ou inválido.'),
          actions: [
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
  }
}

void loginValidationDonator(TextEditingController emailwritten,

    TextEditingController senhawritten, BuildContext context) async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('userdonate').get();

  if (querySnapshot.size > 0) {
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      // Acesso aos dados de cada documento individualmente
      Map<String, dynamic>? userData =
          docSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        // Faça o que for necessário com os dados do usuário
        String email = userData['email'];
        String senha = userData['senha'];

        if (email == emailwritten.text && senha == senhawritten.text) {
          DonatorData donatorData = DonatorData(
            email: userData['email'],
            nome: userData['nome'],
            sexo: userData['sexo'],
            idade: userData['idade'],
            senha: userData['senha'],
            endereco: userData['endereço'],
            cpf: userData['cpf'],
            peso: userData['peso'],
            tipoSangue: userData['tipo_sanguineo'],
            substancias: userData['substancias'],
            data: (userData['data'] as Timestamp).toDate(),
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginDonator(donatorData: donatorData)));
          // Aguardar 0,5 segundos antes de exibir o diálogo de erro
          flag = 1;
          await Future.delayed(Duration(milliseconds: 500));

          //signup screen
        } else if (email != emailwritten.text && senha != senhawritten.text && flag == 0){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('E-mail ou senha inválidos.'),
                actions: [
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Fechar o diálogo
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainPage()));
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
