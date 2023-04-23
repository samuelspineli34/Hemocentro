import 'package:flutter/material.dart';
import 'package:tela_login/main.dart';
import 'shared/libs.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class LoginHemocenter extends StatelessWidget {
  @override
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final endereco = TextEditingController();
  final cnpj = TextEditingController();
  final sangue = TextEditingController();

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
              DefaultTextFields.getTextField('Senha', senha),
              DefaultTextFields.getTextField('Endereco', endereco),
              DefaultTextFields.getTextField('CNPJ', cnpj),
              DefaultTextFields.getTextField('Tipos sanguineos necessitados', sangue),
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
