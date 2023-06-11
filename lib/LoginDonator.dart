import 'package:flutter/material.dart';
import 'package:hemocentro1/MapHemo.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/donatorData.dart';

String data2 = "";
String data = getCurrentDate();

String getCurrentDate() {
  DateTime now = DateTime.now();
  String formattedDate = '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateF() {
  DateTime now = DateTime.now();
  now = now.add(Duration(days: 90));
  String formattedDate = '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateM() {
  DateTime now = DateTime.now();
  now = now.add(Duration(days: 60));
  String formattedDate = '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

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
    print("Valor inserido login email: " + donatorData.email);
    checarSexo(donatorData);

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
                  Text('Sexo: ' + donatorData.sexo),
                  Text('Endereço: ' + donatorData.endereco),
                  Text('CPF: ' + donatorData.cpf),
                  Text('Peso (kg): ' + donatorData.peso),
                  Text('Tipo sanguíneo: ' + donatorData.tipoSangue),
                  Text('Data da última doação: ' + data),
                  Text('Apto a doar a partir de: ' + data2),
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
                                      builder: (context) => MapHemo(donatorData: donatorData)));
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
                            print("Valor inserido login nome: " + donatorData.nome);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        )
    );
  }
}

void checarSexo(donatorData) {
  print(donatorData.sexo);
  if (donatorData.sexo == "masculino") {
    data2 = getCurrentDateM();
    print(data2);
  } else if (donatorData.sexo == "feminino") {
    data2 = getCurrentDateF();
    print(data2);
  }
}
