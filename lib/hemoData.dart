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

class HemoData {
  final String email;
  final String nome;
  final String senha;
  final String endereco;
  final String cnpj;
  final String lat;
  final String long;
  final List<String> sangue = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
  ];

  HemoData({
    required this.email,
    required this.nome,
    required this.senha,
    required this.endereco,
    required this.cnpj,
    required this.lat,
    required this.long,
    required List<String>sangue,
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
        'lat': hemoData.lat,
        'long': hemoData.long,
        'sangue': hemoData.sangue,
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

  String docId = querySnapshot.size.toString();

  if (querySnapshot.size > 0) {
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      // Acesso aos dados de cada documento individualmente
      Map<String, dynamic>? userData = docSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        // Faça o que for necessário com os dados do usuário
        String email = userData['email'];
        String senha = userData['senha'];

        if (email == emailwritten.text && senha == senhawritten.text) {
          print("Passou confirmação " + email + " " + senha);
          HemoData hemoData = HemoData(
            email: userData['email'],
            nome: userData['nome'],
            senha: userData['senha'],
            endereco: userData['endereço'],
            cnpj: userData['cnpj'],
            lat: userData['lat'],
            long: userData['long'],
            sangue: userData['sangue'],
          );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginHemocenter(hemoData: hemoData)));
            //signup screen
        }
        else if (email != emailwritten.text && senha != senhawritten.text){
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

Future<String> getHemocenterLatitude(String sangue) async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection('userhemo').get();

  for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
    Map<String, dynamic>? userData =
    docSnapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      String sangueHemocentro = userData['sangue'].toString();

        String latitude = userData['lat'].toString();
        print("lathemo: " + latitude.toString());
        return latitude.toString();
    }
  }

  return "0.00";
}

Future<String> getHemocenterLongitude(String sangue) async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection('userhemo').get();

  for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
    Map<String, dynamic>? userData =
    docSnapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      String sangueHemocentro = userData['sangue'].toString();

        String longitude = userData['long'].toString();
        print("longhemo: " + longitude.toString());
        return longitude.toString();
    }
  }

  return "0.00";
}



void inserirSangue(List<String> sangue, HemoData hemoData, BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userhemo');

  QuerySnapshot querySnapshot = await usersCollection
      .where('email', isEqualTo: hemoData.email)
      .get();

  if (querySnapshot.size > 0) {
    QueryDocumentSnapshot docSnapshot = querySnapshot.docs[0];
    String docId = docSnapshot.id;

    // Recuperar o campo 'sangue' como uma String
    String sangueString = docSnapshot.get('sangue') ?? '';

    // Converter a String em uma lista de tipos de sangue
    List<String> tiposSangue = sangueString.split(',');

    // Adicionar os elementos da nova lista à lista existente, verificando duplicatas
    for (String novoSangue in sangue) {
      if (!tiposSangue.contains(novoSangue)) {
        tiposSangue.add(novoSangue);
      }
    }

    // Atualizar o campo 'sangue' no documento Firestore
    await usersCollection.doc(docId).update({'sangue': tiposSangue.join(',')});

    // Atualizar o objeto HemoData localmente também
    HemoData updatedHemoData = HemoData(
      email: hemoData.email,
      nome: hemoData.nome,
      senha: hemoData.senha,
      endereco: hemoData.endereco,
      cnpj: hemoData.cnpj,
      lat: hemoData.lat,
      long: hemoData.long,
      sangue: tiposSangue,
    );

  }
}



void removerSangue(String sangue, HemoData hemoData, BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection = firestore.collection('userhemo');

  QuerySnapshot querySnapshot = await usersCollection
      .where('email', isEqualTo: hemoData.email)
      .get();

  if (querySnapshot.size > 0) {
    QueryDocumentSnapshot docSnapshot = querySnapshot.docs[0];
    String docId = docSnapshot.id;

    // Recuperar o campo 'sangue' como uma String
    String sangueString = docSnapshot.get('sangue') ?? '';

    // Converter a String em uma lista de tipos de sangue
    List<String> tiposSangue = sangueString.split(',');

// Remover os tipos de sangue selecionados da lista
    tiposSangue.removeWhere((tipo) => sangue.contains(tipo));

// Atualizar o campo 'sangue' no documento Firestore
    await usersCollection.doc(docId).update({'sangue': tiposSangue.join(',')});

// Atualizar o objeto HemoData localmente também
    HemoData updatedHemoData = HemoData(
      email: hemoData.email,
      nome: hemoData.nome,
      senha: hemoData.senha,
      endereco: hemoData.endereco,
      cnpj: hemoData.cnpj,
      lat: hemoData.lat,
      long: hemoData.long,
      sangue: tiposSangue,
    );

// Use o objeto HemoData atualizado como parâmetro para a próxima tela
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginHemocenter(hemoData: updatedHemoData),
      ),
    );
  }
}