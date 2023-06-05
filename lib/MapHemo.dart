import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginDonator.dart';
import 'package:hemocentro1/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<void> fetchAmenities() async {
  final response = await http.get(Uri.parse('https://overpass-api.de/api/interpreter?data=[out:json];node(around:1000,latitude,longitude)[amenity];out;'));

  if (response.statusCode == 200) {
    // Processar a resposta JSON
    final json = jsonDecode(response.body);

  } else {

    print('Erro na solicitação: ${response.statusCode}');
  }
}


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
          body:
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      child:
                      const Text('Voltar', textAlign: TextAlign.center),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                        print("Valor iserido: " + email.text);
                      },
                    ),
                  ),
                ],
        ),
        ),
    );
  }
}
