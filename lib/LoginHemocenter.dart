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
  ]; // Lista de tipos de
  List<String> tiposSangueSelecionados = [];


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
          child: Column(
            children: <Widget>[
              Text('E-mail: ' + hemoData.email),
              Text('Nome: ' + hemoData.nome),
              Text('Senha: ' + hemoData.senha),
              Text('Endereço: ' + hemoData.endereco),
              Text('CNPJ: ' + hemoData.cnpj),
              Text('Tipos sanguíneos necessitados: '),
              Container (
                padding: EdgeInsets.fromLTRB(200, 5, 200, 0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tiposSangue.length,
                itemBuilder: (BuildContext context, int index) {
                  final tipoSangue = tiposSangue[index];
                  final isChecked = tiposSangueSelecionados.contains(tipoSangue);

                  return CheckboxListTile(
                    title: Text(tipoSangue),
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        if (newValue == true) {
                          tiposSangueSelecionados.add(tipoSangue);
                          inserirSangue(tiposSangueSelecionados, hemoData, context);
                        } else {
                          tiposSangueSelecionados.remove(tipoSangue);
                          removerSangue(tipoSangue, hemoData, context);
                        }
                      });
                    },
                  );
                },
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                    child: ElevatedButton(
                      child: const Text('Sair', textAlign: TextAlign.center),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






