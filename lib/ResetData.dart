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

class ResetData {
  final String email;
  final String senha;

  ResetData({
    required this.email,
    required this.senha,
  });
}


void saveUserDonatorData(ResetData resetData, BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userdonate');
  if (
      resetData.email != "" &&
      resetData.senha != ""
      ) {
    try {
      await usersCollection.add({
       'email': resetData.email,
        'senha': resetData.senha,
      });

      print('Dados do usuário doador salvos com sucesso.');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()));
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
          ResetData resetData = ResetData(
            email: userData['email'],
            senha: userData['senha'],
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()));
          //signup screen
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('E-mail ou senha inválidos.'),
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
    }
  }
}
