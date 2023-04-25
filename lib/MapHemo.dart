import 'package:flutter/material.dart';
import 'package:tela_login/LoginDonator.dart';
import 'package:tela_login/main.dart';
import 'shared/libs.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MapHemo extends StatelessWidget {
  @override
  final email = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final endereco = TextEditingController();
  final cnpj = TextEditingController();

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Localização de Hemocentros Próximos",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Localização de Hemocentros Próximos"),
          ),
          body: Container(
            decoration: BoxDecoration(
                // Background
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
            ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ElevatedButton(
                    child: const Text('Voltar', textAlign: TextAlign.center),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginDonator()));
                      print("Valor iserido: " + email.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
