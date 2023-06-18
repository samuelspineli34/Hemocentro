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
double generateRandomLatitude({double min = 37, double max = 38}) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}

// Função para gerar longitude aleatória
double generateRandomLongitude({double min = -121, double max = -122}) {
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
          appBar:  AppBar(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),
            backgroundColor: const Color(0xFFD32F2F),
            title: const Text('Tela de registro hemocentro'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: 'Nome da instituição',
                      labelStyle: TextStyle(
                          color: Color(0xFFD32F2F), fontSize: 20)),
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: nome,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                          color: Color(0xFFD32F2F), fontSize: 20)),
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: email,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Color(0xFFD32F2F),
                          fontSize: 20),
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
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD32F2F))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD32F2F))),
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(color: Color(0xFFD32F2F),
                        fontSize: 20),
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
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: 'Endereço',
                      labelStyle: TextStyle(
                          color: Color(0xFFD32F2F), fontSize: 20)),
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: endereco,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CnpjInputFormatter(), // Classe de formatação personalizada para o CNPJ
                  ],
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: 'CNPJ',
                      labelStyle: TextStyle(
                          color: Color(0xFFD32F2F), fontSize: 20)),
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
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
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
                      child: const Text('Cadastrar', textAlign: TextAlign.center),
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
