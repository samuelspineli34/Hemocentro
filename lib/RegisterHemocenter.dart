import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginHemocenter.dart';
import 'package:hemocentro1/main.dart';
import 'shared/libs.dart';
import 'package:hemocentro1/hemoData.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
                ),
              ),
              DefaultTextFields.getTextField('Endereco', endereco),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "CNPJ",
                  ),
                  maxLength: 11,
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
                        );
                        saveUserHemoData(hemoData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginHemocenter(hemoData: hemoData)));
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
