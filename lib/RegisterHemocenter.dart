import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginHemocenter.dart';
import 'package:hemocentro1/main.dart';
import 'shared/libs.dart';
import 'package:hemocentro1/hemoData.dart';
import 'package:flutter/services.dart';
import 'package:hemocentro1/dataInputs.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:math';

// Função para gerar latitude aleatória
double generateRandomLatitude({double min = -90, double max = 90}) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}

// Função para gerar longitude aleatória
double generateRandomLongitude({double min = -180, double max = 180}) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}

class RegisterHemocenter extends StatefulWidget {
  @override
  _RegisterHemocenter createState() => _RegisterHemocenter();
}

class _RegisterHemocenter extends State<RegisterHemocenter> {
  @override
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  final endereco = TextEditingController();
  final cnpj = TextEditingController();
  final double lat = generateRandomLatitude();
  final double long = generateRandomLongitude();
  bool elegivel = false;

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Registro Hemocentro",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tela registro hemocentro"),
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              DefaultTextFields.getTextField('Nome da Instituição', nome),
              DefaultTextFields.getTextField('E-mail', email),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Senha",
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
                  maxLength: 50,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: senha,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Confirmar Senha",
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
                  maxLength: 50,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: confirmarsenha,
                  onTapOutside: (val) {
                    checarSenha(senha, confirmarsenha, context, elegivel);
                  },
                ),
              ),
              DefaultTextFields.getTextField('Endereco', endereco),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CnpjInputFormatter(), // Classe de formatação personalizada para o CPF
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "CNPJ",
                  ),
                  maxLength: 18,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: cnpj,
                ),
              ),
              /*MultiSelectDialogField(
                items: _animals.map((e) => MultiSelectItem(e, e.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  _selectedAnimals = values;
                },
              ),*/

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                    child: ElevatedButton(
                        child:
                            const Text('Voltar', textAlign: TextAlign.center),
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
                      child:
                          const Text('Cadastrar', textAlign: TextAlign.center),
                      onPressed: () {
                        HemoData hemoData = HemoData(
                          email: email.text,
                          nome: nome.text,
                          senha: senha.text,
                          endereco: endereco.text,
                          cnpj: cnpj.text,
                          lat: lat.toString(),
                          long: long.toString(),
                          sangue: [],
                        );
                        saveUserHemoData(hemoData, context);
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

void checarSenha(TextEditingController senha, TextEditingController confirmarsenha, BuildContext context, bool elegivel) {

  if (senha.text != confirmarsenha.text) {
    elegivel = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senhas não correspondem'),
          content: Text(
              'As senhas digitadas não correspondem. Por favor, tente novamente.'),
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
  else
    {
      elegivel = true;
    }
}
