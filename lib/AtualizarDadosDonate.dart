import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hemocentro1/LoginDonator.dart';
//import 'package:hemocentro1/LoginHemocenter.dart';
import 'package:hemocentro1/RegisterDonate.dart';
import 'package:hemocentro1/RegisterHemocenter.dart';
import 'package:hemocentro1/donatorData.dart';
//import 'package:hemocentro1/hemoData.dart';
import 'package:hemocentro1/main.dart';

import 'services/remote_service.dart';
import 'models/post.dart';
import 'shared/libs.dart';
import 'shared/constants.dart';
import 'package:hemocentro1/firebase_options.dart';

class AtualizarDadosDonate extends StatefulWidget {
  final DonatorData donatorData;

  AtualizarDadosDonate({required this.donatorData});

  @override
  _AtualizarDadosDonateState createState() =>
      _AtualizarDadosDonateState(donatorData : donatorData);
}

class _AtualizarDadosDonateState extends State<AtualizarDadosDonate> {
  bool _isPasswordVisible = false;
  final DonatorData donatorData;
  late TextEditingController nomeController;
  late TextEditingController enderecoController;
  late TextEditingController emailController;
  late TextEditingController senhaController;
  /*late TextEditingController enderecoController;
  late TextEditingController nomeController;
  late TextEditingController enderecoController;
  late TextEditingController nomeController;
  late TextEditingController enderecoController;*/

  _AtualizarDadosDonateState({required this.donatorData});

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: donatorData.nome);
    enderecoController = TextEditingController(text: donatorData.endereco);
    emailController = TextEditingController(text: donatorData.email);
    senhaController = TextEditingController(text: donatorData.senha);
  }

  @override
  void dispose() {
    nomeController.dispose();
    enderecoController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> atualizarDados() async {
    String email = donatorData.email; // Obtém o email do usuário logado
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('userdonate');

    // Pesquisa o documento com base no email do usuário
    QuerySnapshot querySnapshot = await collection.where('email', isEqualTo: email.toString()).get();
    if (querySnapshot.size > 0) {
      QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      String docId = documentSnapshot.id;

      try {
        await collection.doc(docId).update({
          'nome': nomeController.text,
          'endereco': enderecoController.text,
          'email': emailController.text,
          'senha': senhaController.text,
          // Adicione outros campos e valores que deseja atualizar
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dados atualizados com sucesso')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar os dados: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário não encontrado')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Dados Doador'),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(80, 30, 80, 0),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD32F2F))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD32F2F))),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Color(0xFFD32F2F),
                        fontSize: 20),
                    contentPadding: EdgeInsets.all(10.0)),
                style: TextStyle(color: Colors.black, fontSize: 20),
                controller: emailController,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(80, 50, 80, 50),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD32F2F))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD32F2F))),
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Color(0xFFD32F2F),
                      fontSize: 20),
                  contentPadding: EdgeInsets.all(10.0),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                style: TextStyle(color: Colors.black, fontSize: 20),
                controller: senhaController,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
                child: const Text('Atualizar', textAlign: TextAlign.center),
                onPressed: () {
                  atualizarDados();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginDonator(donatorData: donatorData)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
