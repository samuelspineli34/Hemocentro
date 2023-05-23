import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginDonator.dart';
import 'shared/libs.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/donatorData.dart';

class RegisterDonate extends StatefulWidget {
  @override
  _RegisterDonateState createState() => _RegisterDonateState();
}

class _RegisterDonateState extends State<RegisterDonate> {
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  final endereco = TextEditingController();
  final cpf = TextEditingController();
  final peso = TextEditingController();
  final substancias = TextEditingController();
  String? tipossangue = "A+"; // Variável para armazenar o tipo de sangue selecionado

  List<String> tiposSangue = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ]; // Lista de tipos de sangue

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  @override
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
                    ),
                  ),
                  /*    DefaultTextFields.getTextField(
                if (senha == confirmarsenha) {
                  return "Senha errada";
              },
              ),*/
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "CPF",
                      ),
                      maxLength: 11,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      controller: cpf,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "Peso (kg)",
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      controller: peso,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(55, 0, 50, 25),
                        child: Text(
                          'Tipo sanguíneo',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      DropdownButton<String>(
                        value: tipossangue,
                        hint: Text('Selecione'),
                        onChanged: (String? newValue) {
                          setState(() {
                            tipossangue = newValue;
                          });
                        },
                        items: tiposSangue.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  DefaultTextFields.getTextField(
                      'Utiliza alguma substância ilicita?', substancias),
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
                          child: const
                          Text('Cadastrar', textAlign: TextAlign.center),
                          onPressed: () {
                          DonatorData donatorData = DonatorData(
                          email: email.text,
                          nome: nome.text,
                          senha: senha.text,
                          endereco: endereco.text,
                          cpf: cpf.text,
                          peso: peso.text,
                          tipoSangue: tipossangue!,
                          substancias: substancias.text,
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginDonator(donatorData: donatorData)));
                        print("Valor iserido: " + email.text);
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
