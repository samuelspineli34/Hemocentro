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
            title: Text("Tela registro doador"),
          ),
          body:
          SingleChildScrollView(
            child: Column(children: <Widget>[
              DefaultTextFields.getTextField('E-mail', email),
              Container(
                //Campo para registrar o nome
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Nome",
                  ),
                  maxLength: 50,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: nome,
                ),
              ),
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
              RadioListTile(
                title: Text("Masculino"),
                value: false,
                groupValue: _isCheckedM,
                onChanged: (value) {
                  setState(() {
                    _isCheckedM = value!;
                    _isCheckedF = value;
                  });
                  checarSexo(_isCheckedM, _isCheckedF, sexo);
                },
              ),
              RadioListTile(
                title: Text("Feminino"),
                value: true,
                groupValue: _isCheckedF,
                onChanged: (value) {
                  setState(() {
                    _isCheckedF = value!;
                    _isCheckedM = value;
                  });
                  checarSexo(_isCheckedM, _isCheckedF, sexo);
                },
              ),
              Container(
                //Campo para registrar a idade
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Idade",
                  ),
                  maxLength: 3,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: idade,
                ),
              ),
              Container(
                //Campo para registrar o endereço
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Endereço",
                  ),
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: endereco,
                ),
              ),
              Container(
                //Campo para registrar o CPF
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(), // Classe de formatação personalizada para o CPF
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "CPF",
                  ),
                  maxLength: 14,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: cpf,
                ),
              ),
              Container(
                //Campo para registrar o peso
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [WeightInputFormatter()],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Peso (kg)",
                  ),
                  maxLength: 6,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  controller: peso,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(55, 10, 50, 25),
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
                        alignment: Alignment.center,
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
                    child: Text(
                      'Utilia alguma substância ilícita?',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  DropdownButton<String>(
                    value: substancias,
                    hint: Text('Selecione'),
                    onChanged: (String? newValue) {
                      setState(() {
                        substancias = newValue;
                      });
                    },
                    items: Substancias.map((String value) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
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
                          const Text('Cadastrar', textAlign: TextAlign.center),
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
                          tipoSangue: tipossangue!,
                          substancias: substancias!,
                          data: data
                        );
                        saveUserDonatorData(donatorData, context);
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

void checarSexo(bool inputM, bool inputF, TextEditingController sexo) {
  if (inputM = true) {
    sexo.text = "masculino";
  } else if (inputF = true) {
    sexo.text = "feminino";
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
