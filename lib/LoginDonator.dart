import 'package:flutter/material.dart';
import 'package:hemocentro1/MapHemo.dart';
import 'shared/libs.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/RegisterDonate.dart';
import 'package:hemocentro1/donatorData.dart';

class LoginDonator extends StatelessWidget {

  final DonatorData donatorData;

  LoginDonator({required this.donatorData});

  @override

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    print("Valor iserido login email: " + donatorData.email);
    return MaterialApp(
        title: "Informações Doador",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Suas informações"),
          ),
          body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Text('E-mail: ' + donatorData.email),
                  Text('Nome: ' + donatorData.nome),
                  Text('Senha: ' + donatorData.senha),
                  Text('Endereço: ' + donatorData.endereco),
                  Text('CPF: ' + donatorData.cpf),
                  Text('Peso (kg): ' + donatorData.peso),
                  Text('Tipo sanguíneo: ' + donatorData.tipoSangue),
                  Text('Data da última doação: '),
                  Text('Apto a doar: ' ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                        child: ElevatedButton(
                            child: const Text('Mapa Hemocentro',
                                textAlign: TextAlign.center),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapHemo()));
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ElevatedButton(
                          child:
                          const Text('Sair', textAlign: TextAlign.center),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                            print("Valor iserido login nome: " + donatorData.nome);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
