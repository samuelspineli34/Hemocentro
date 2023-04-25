import 'package:flutter/material.dart';
import 'package:tela_login/LoginDonator.dart';
import 'shared/libs.dart';
import 'package:tela_login/main.dart';

class RegisterDonate extends StatelessWidget {
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

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Registro Doador",
        home: Scaffold(
            appBar: AppBar(
              title: Text("Tela registro doador"),
            ),
            body: Container(
              decoration: BoxDecoration(
                  // Background
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  DefaultTextFields.getTextField('E-mail', email),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                        child: ElevatedButton(
                            child: const Text('Voltar',
                                textAlign: TextAlign.center),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ElevatedButton(
                          child: const Text('Cadastrar',
                              textAlign: TextAlign.center),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginDonator()));
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
