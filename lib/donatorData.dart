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

class DonatorData {
  final String email;
  final String nome;
  final String senha;
  final String endereco;
  final String cpf;
  final String peso;
  final String tipoSangue;
  final String substancias;

  DonatorData({
    required this.email,
    required this.nome,
    required this.senha,
    required this.endereco,
    required this.cpf,
    required this.peso,
    required this.tipoSangue,
    required this.substancias,
  });
}

void saveUserDonatorData(DonatorData userData) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userdonate');

  try {
    await usersCollection.add({
      'nome': userData.nome,
      'email': userData.email,
      'senha': userData.senha,
      'endereço': userData.endereco,
      'cpf': userData.cpf,
      'peso': userData.peso,
      'tipo_sanguineo': userData.tipoSangue,
      'substancias': userData.substancias,
    });

    print('Dados do usuário doador salvos com sucesso.');
  } catch (error) {
    print('Erro ao salvar os dados do usuário doador: $error');
  }
}

void loginValidationDonator(TextEditingController emailwritten, TextEditingController senhawritten, BuildContext context) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('userdonate').get();
  print("teste1");

  if (querySnapshot.size > 0) {
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      // Acesso aos dados de cada documento individualmente
      Map<String, dynamic>? userData = docSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        print("teste2");
        // Faça o que for necessário com os dados do usuário
        String email = userData['email'];
        String senha = userData['senha'];
        print("email: " + email);
        print("senha: " + senha);
        print("email hemo: " + emailwritten.text);
        print("senha senha: " + senhawritten.text);
        if (email == emailwritten.text && senha == senhawritten.text) {
          print("teste3");
          DonatorData donatorData = DonatorData(
            email: userData['email'],
            nome: userData['nome'],
            senha: userData['senha'],
            endereco: userData['endereço'],
            cpf: userData['cpf'],
            peso: userData['peso'],
            tipoSangue: userData['tipo_sanguinio'],
            substancias: userData['substancias'],
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginDonator(donatorData: donatorData)));
          //signup screen
        }
        else {
          print("E-mail ou senha inválidos");
        }
      }
    }
  }
}