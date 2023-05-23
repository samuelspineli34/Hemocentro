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

import 'services/remote_service.dart';
import 'models/post.dart';
import 'shared/libs.dart';
import 'shared/constants.dart';
import 'package:hemocentro1/firebase_options.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class HemoData {
  final String email;
  final String nome;
  final String senha;
  final String endereco;
  final String cnpj;

  HemoData({
    required this.email,
    required this.nome,
    required this.senha,
    required this.endereco,
    required this.cnpj,
  });
}

void saveUserHemoData(HemoData hemoData, BuildContext context) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userhemo');

  if (hemoData.nome != "" &&
      hemoData.email != "" &&
      hemoData.senha != "" &&
      hemoData.endereco != "" &&
      hemoData.cnpj != "") {
    try {
      await usersCollection.add({
        'nome': hemoData.nome,
        'email': hemoData.email,
        'senha': hemoData.senha,
        'endereço': hemoData.endereco,
        'cnpj': hemoData.cnpj,
      });
      print('Dados do usuário hemocentro salvos com sucesso.');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginHemocenter(hemoData: hemoData)));
    } catch (error) {
      print('Erro ao salvar os dados do usuário hemocentro: $error');
    }
  }
     else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Algum campo foi deixado vazio.'),
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
}


void loginValidationHemo(TextEditingController emailwritten, TextEditingController senhawritten, BuildContext context) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('userhemo').get();

  if (querySnapshot.size > 0) {
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      // Acesso aos dados de cada documento individualmente
      Map<String, dynamic>? userData = docSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        // Faça o que for necessário com os dados do usuário
        String email = userData['email'];
        String senha = userData['senha'];
        if (email == emailwritten.text && senha == senhawritten.text) {
          HemoData hemoData = HemoData(
            email: userData['email'],
            nome: userData['nome'],
            senha: userData['senha'],
            endereco: userData['endereço'],
            cnpj: userData['cnpj'],
          );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginHemocenter(hemoData: hemoData)));
            //signup screen
        }
        else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                    'E-mail ou senha inválidos.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Fechar o diálogo
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