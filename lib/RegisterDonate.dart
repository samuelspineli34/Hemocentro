import 'package:flutter/material.dart';
import 'shared/libs.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DefaultTextFields.getTextField('E-mail', email),
              DefaultTextFields.getTextField('Nome', nome),
              DefaultTextFields.getTextField('Senha', senha),
              DefaultTextFields.getTextField('Confirmar Senha', confirmarsenha),
          /*    DefaultTextFields.getTextField(
                if (senha == confirmarsenha) {
                  return "Senha errada";
              },
              ),*/
              DefaultTextFields.getTextField('Endereco', endereco),
              DefaultTextFields.getTextField('CPF', cpf),
              DefaultTextFields.getTextField('Peso (kg)', peso),
              DefaultTextFields.getTextField('Tipo sanguíneo', tiposangue),
              DefaultTextFields.getTextField('Utiliza alguma substância ilicita?', substancias),

              Container(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text('Cadastrar', textAlign: TextAlign.center),
                  onPressed: () {
                    print("Valor iserido: " + nome.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
