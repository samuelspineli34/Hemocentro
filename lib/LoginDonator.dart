import 'package:flutter/material.dart';
import 'package:hemocentro1/MapHemo.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/donatorData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

String data2 = "";
String data = getCurrentDate();

List<String> bancos = [];

void compararSangue(DonatorData donatorData) async {
  String sangueuser = donatorData.tipoSangue;

  await _recursivamenteBuscarCompatibilidade(sangueuser, bancos, null);
}

Future<void> _recursivamenteBuscarCompatibilidade(String sangueuser,
    List<String> bancos, DocumentSnapshot? lastDocument) async {
  bool hasMoreData = true;

  while (hasMoreData) {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('userhemo').get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? userData =
          docSnapshot.data() as Map<String, dynamic>?;

      int tam = docSnapshot.id.length;

      while (tam > 0) {
        if (userData != null) {
          String sanguehemo = userData['sangue'].toString();
          String docId = docSnapshot.id;

          // Verificar compatibilidade de sangue e adicionar à lista se for compatível
          if (sangueuser == "O-") {
            if (sanguehemo.contains("O-")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "O+") {
            if (sanguehemo.contains("O+") ||
                sanguehemo.contains("A+") ||
                sanguehemo.contains("B+") ||
                sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "A+") {
            if (sanguehemo.contains("A+") || sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "A-") {
            if (sanguehemo.contains("A-") ||
                sanguehemo.contains("A+") ||
                sanguehemo.contains("AB-") ||
                sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "B+") {
            if (sanguehemo.contains("B+") || sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "B-") {
            if (sanguehemo.contains("B-") ||
                sanguehemo.contains("B+") ||
                sanguehemo.contains("AB-") ||
                sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "AB+") {
            if (sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          } else if (sangueuser == "AB-") {
            if (sanguehemo.contains("AB-") || sanguehemo.contains("AB+")) {
              bancos.add(docId.toString());
            }
          }
        }
      }
      print("Lista de bancos compatíveis: " + bancos[tam]);
      tam--;
    }
  }
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateF(DonatorData donatorData) {
  DateTime now = donatorData.data;
  now = now.add(Duration(days: 90));
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateM(DonatorData donatorData) {
  DateTime now = donatorData.data;
  now = now.add(Duration(days: 60));
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

class LoginDonator extends StatefulWidget {
  final DonatorData donatorData;

  LoginDonator({required this.donatorData});

  @override
  _LoginDonatorState createState() => _LoginDonatorState();
}

class _LoginDonatorState extends State<LoginDonator> {
  List<String> bancos = [];

  @override
  void initState() {
    super.initState();
    compararSangue(widget.donatorData);
  }

  TextField padrao(TextEditingController controlador, String templateField) {
    return TextField(
      controller: controlador,
    );
  }

  Widget build(BuildContext context) {
    print("Valor inserido login email: " + widget.donatorData.email);
    checarSexo(widget.donatorData);
    DateTime dateTime = widget.donatorData.data;

    return MaterialApp(
      title: "Informações Doador",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Suas informações"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('E-mail: ' + widget.donatorData.email),
              Text('Nome: ' + widget.donatorData.nome),
              Text('Sexo: ' + widget.donatorData.sexo),
              Text('Endereço: ' + widget.donatorData.endereco),
              Text('CPF: ' + widget.donatorData.cpf),
              Text('Peso (kg): ' + widget.donatorData.peso),
              Text('Tipo sanguíneo: ' + widget.donatorData.tipoSangue),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Data da ultima doação: ',
                    //style: Styles.textoTempoEntrega,
                  ),
                ],
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                child: TableCalendar(
                  // Configurações e personalizações do calendário aqui
                  // Consulte a documentação para todas as opções disponíveis
                  firstDay: DateTime.now(),
                  focusedDay: widget.donatorData.data,
                  lastDay: DateTime.now().add(50),,
                  calendarController: CalendarController(), // Controlador do calendário
                  onDaySelected: (date, events) {
                    // Callback quando um dia for selecionado
                    // Você pode adicionar sua lógica aqui
                    print('Data selecionada: $date');
                  },
                ),

              ),
              Text('Apto a doar a partir de: ' + data2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                    child: ElevatedButton(
                      child: const Text('Hemocentros compatíveis',
                          textAlign: TextAlign.center),
                      onPressed: () {
                        compararSangue(widget.donatorData);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                    child: ElevatedButton(
                      child: const Text('Mapa Hemocentro',
                          textAlign: TextAlign.center),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapHemo(
                              donatorData: widget.donatorData,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      child: const Text('Sair', textAlign: TextAlign.center),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                        print("Valor inserido login nome: " +
                            widget.donatorData.nome);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                child: Text('Hemocentro' + bancos.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void checarSexo(donatorData) {
  print(donatorData.sexo);
  if (donatorData.sexo == "masculino") {
    data2 = getCurrentDateM(donatorData);
    print(data2);
  } else if (donatorData.sexo == "feminino") {
    data2 = getCurrentDateF(donatorData);
    print(data2);
  }
}
