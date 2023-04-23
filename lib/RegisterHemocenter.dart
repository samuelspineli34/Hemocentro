import 'package:flutter/material.dart';
import 'shared/libs.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterHemocenter extends StatelessWidget {
  @override
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final endereco = TextEditingController();
  final cnpj = TextEditingController();

  TextField padrao(TextEditingController controlador, String templateField){
    return TextField(
      controller: controlador,
    );
  }



  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registro Hemocentro",
      home: Scaffold(
        appBar: AppBar(title: Text("Tela registro hemocentro"),),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              DefaultTextFields.getTextField('Nome da Instituição', nome),
              DefaultTextFields.getTextField('E-mail', email),
              DefaultTextFields.getTextField('Senha', senha),
              DefaultTextFields.getTextField('Endereco', endereco),
              DefaultTextFields.getTextField('CNPJ', cnpj),
              /*MultiSelectDialogField(
                items: _animals.map((e) => MultiSelectItem(e, e.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  _selectedAnimals = values;
                },
              ),*/

              Container(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text('Cadastrar', textAlign: TextAlign.center),
                  onPressed: () {
                    print("Valor iserido: " + email.text);
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