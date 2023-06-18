import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemocentro1/dataInputs.dart';
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
  final sexo = TextEditingController();
  final idade = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  final endereco = TextEditingController();
  final cpf = TextEditingController();
  final peso = TextEditingController();
  bool elegivel = true;
  bool _isCheckedF = false;
  bool _isCheckedM = true;
  final DateTime data = DateTime.now();

  String? tipossangue =
      "A+"; // Variável para armazenar o tipo de sangue selecionado

  List<String> tiposSangue = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  String? substancias =
      "Sim"; // Variável para armazenar o tipo de sangue selecionado

  List<String> Substancias = [
    'Sim',
    'Não',
  ]; //// Lista de tipos de sangue

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
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.bloodtype)),
            backgroundColor: const Color(0xFFD32F2F),
            title: const Text('Tela de registro doador'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'Nome',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Color(0xFFD32F2F),
                        value: _isCheckedM,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedM = value!;
                            _isCheckedF = false;
                            checarSexo(_isCheckedM, _isCheckedF, sexo);
                          });
                        },
                      ),
                      Text("Masculino",
                          style: TextStyle(color: Color(0xFFD32F2F))),
                      Checkbox(
                        activeColor: Color(0xFFD32F2F),
                        value: _isCheckedF,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedF = value!;
                            _isCheckedM = false;
                            checarSexo(_isCheckedM, _isCheckedF, sexo);
                          });
                        },
                      ),
                      Text("Feminino",
                          style: TextStyle(color: Color(0xFFD32F2F))),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'Idade',
                          labelStyle: TextStyle(
                              color: Color(0xFFD32F2F), fontSize: 20)),
                      maxLength: 2,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      controller: idade,
                    ),
                  ),
                  Container(
                    //Campo para confirmar a senha
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD32F2F))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD32F2F))),
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "Senha",
                        labelStyle:
                            TextStyle(color: Color(0xFFD32F2F), fontSize: 20),
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
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD32F2F))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD32F2F))),
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "Confirmar Senha",
                        labelStyle:
                            TextStyle(color: Color(0xFFD32F2F), fontSize: 20),
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
                      maxLength: 50,
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
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(), // Classe de formatação personalizada para o CPF
                      ],
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'CPF',
                          labelStyle: TextStyle(
                              color: Color(0xFFD32F2F), fontSize: 20)),
                      maxLength: 14,
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
                      inputFormatters: [WeightInputFormatter()],
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'Peso (kg)',
                          labelStyle: TextStyle(
                              color: Color(0xFFD32F2F), fontSize: 20)),
                      maxLength: 6,
                      controller: peso,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'Tipo sanguíneo',
                          labelStyle: TextStyle(
                              color: Color(0xFFD32F2F), fontSize: 20)),
                      value: tipossangue,
                      items: tiposSangue.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFD32F2F)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          tipossangue = newValue!;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD32F2F))),
                          labelText: 'Usa alguma substância?',
                          labelStyle: TextStyle(
                              color: Color(0xFFD32F2F), fontSize: 20)),
                      value: substancias,
                      items: Substancias.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFD32F2F)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          substancias = newValue!;
                        });
                      },
                    ),
                  ),
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
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFD32F2F))),
                            child: const Text('Cadastrar',
                                textAlign: TextAlign.center),
                            onPressed: () {
                              DonatorData donatorData = DonatorData(
                                  email: email.text,
                                  nome: nome.text,
                                  sexo: sexo.text,
                                  idade: idade.text,
                                  senha: senha.text,
                                  endereco: endereco.text,
                                  cpf: cpf.text,
                                  peso: peso.text,
                                  tipoSangue: tipossangue.toString(),
                                  substancias: substancias.toString(),
                                  data: DateTime.now()
                              );
                              saveUserDonatorData(donatorData, context);
                            },
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}

void checarSexo(bool inputM, bool inputF, TextEditingController sexo) {
  if (inputM = true) {
    sexo.text = "masculino";
  } else if (inputF = true) {
    sexo.text = "feminino";
  }
}

void checarSenha(TextEditingController senha,
    TextEditingController confirmarsenha, BuildContext context, bool elegivel) {
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
  } else {
    elegivel = true;
  }
}
