import 'package:flutter/material.dart';
import 'package:tela_login/MapHemo.dart';
import 'shared/libs.dart';
import 'package:tela_login/main.dart';

class LoginDonator extends StatelessWidget {
  @override
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  final endereco = TextEditingController();
  final cpf = TextEditingController();
  final peso = TextEditingController();
  final tiposangue = TextEditingController();
  final substancias = TextEditingController();
  final periodo = TextEditingController();
  final apto = TextEditingController();

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Informações Doador",
        home: Scaffold(
            appBar: AppBar(
              title: Text("Suas informações"),
            ),
            body: Container(
              decoration: BoxDecoration(
                  // Background
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                      color: Colors.white,
                      child: const Text('E-mail', textAlign: TextAlign.left)),
                  DefaultTextFields.getTextField('Nome', nome),
                  DefaultTextFields.getTextField('Senha', senha),
                  DefaultTextFields.getTextField(
                      'Confirmar Senha', confirmarsenha),
                  /*    DefaultTextFields.getTextField(
                if (senha == confirmarsenha) {
                  return "Senha errada";
              },
              ),*/
                  DefaultTextFields.getTextField('Endereco', endereco),
                  DefaultTextFields.getTextField('CPF', cpf),
                  DefaultTextFields.getTextField('Peso (kg)', peso),
                  DefaultTextFields.getTextField('Tipo sanguíneo', tiposangue),
                  DefaultTextFields.getTextField(
                      'Utiliza alguma substância ilicita?', substancias),
                  DefaultTextFields.getTextField(
                      'Data da última doação', periodo),
                  DefaultTextFields.getTextField('Apto a doar', apto),
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
                            print("Valor iserido: " + email.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )));
  }
}
