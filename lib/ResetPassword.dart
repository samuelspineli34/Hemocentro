import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemocentro1/dataInputs.dart';
import 'package:hemocentro1/LoginDonator.dart';
import 'shared/libs.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/ResetData.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  bool elegivel = true;

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Alterar senha",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tela alterar senha"),
          ),
          body:
          SingleChildScrollView(
            child: Column(children: <Widget>[
              DefaultTextFields.getTextField('E-mail', email),
              Container(
                //Campo para registrar a senha
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextFormField(
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
                //Campo para confirmar a senha
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                    child: ElevatedButton(
                      child: const Text('Voltar', textAlign: TextAlign.center),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      child:
                      const Text('Alterar senha', textAlign: TextAlign.center),
                      onPressed: () {
                        ResetData resetData = ResetData(
                          email: email.text,
                          senha: senha.text,
                        );
                        saveUserDonatorData(resetData, context);
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
