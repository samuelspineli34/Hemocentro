import 'package:flutter/material.dart';
import 'package:hemocentro1/main.dart';
import 'shared/libs.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:hemocentro1/hemoData.dart';

class LoginHemocenter extends StatefulWidget {

  final HemoData hemoData;

  LoginHemocenter({required this.hemoData});

  _LoginHemocenter createState() => _LoginHemocenter(hemoData: hemoData);

}

class _LoginHemocenter extends State<LoginHemocenter> {

  final HemoData hemoData;
  _LoginHemocenter({required this.hemoData});

  @override
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

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Registro Hemocentro",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tela registro hemocentro"),
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Text('E-mail: ' + hemoData.email),
              Text('Nome: ' + hemoData.nome),
              Text('Senha: ' + hemoData.senha),
              Text('Endereço: ' + hemoData.endereco),
              Text('CNPJ: ' + hemoData.cnpj),
              Text('Tipos sanguineos necessitados: '),
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
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                    child: ElevatedButton(
                        child: const Text('Sair',
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        }),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
