import 'package:flutter/material.dart';
import 'package:hemocentro1/MapHemo.dart';
import 'package:hemocentro1/main.dart';
import 'package:hemocentro1/donatorData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:table_calendar/table_calendar.dart';

String data2 = "";
String data = "";
DateTime date1 = DateTime(2023);
DateTime? dateTime = DateTime(2023);

List<String> bancos = [];

void compararSangue(DonatorData donatorData) async {
  String sangueuser = donatorData.tipoSangue;

  await _recursivamenteBuscarCompatibilidade(sangueuser, bancos, null);
}

Future<void> _recursivamenteBuscarCompatibilidade(
    String sangueuser, List<String> bancos, DocumentSnapshot? lastDocument) async {
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
        tam--;
      }
    }
    hasMoreData = false; // Atualizar o valor de hasMoreData para false
  }
}

String getCurrentDate(DateTime dateTime) {
  DateTime now = dateTime;
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateF(DateTime dateTime) {
  DateTime now = dateTime;
  now = now.add(Duration(days: 90));
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String formatDate(DateTime dateTime) {
  DateTime now = dateTime;
  String formattedDate =
      '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${_twoDigits(now.year)}';
  return formattedDate;
}

String getCurrentDateM(DateTime dateTime) {
  DateTime now = dateTime;
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
  DateTime? _selectedDate;

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

  String genero (String sexo)
  {
   if(sexo == "masculino")
     {
       sexo == 'male';
       return sexo;
     }
   else
     {
       sexo == 'female';
       return sexo;
     }
  }



  Widget build(BuildContext context) {
    print("Valor inserido login email: " + widget.donatorData.email);

    DateTime dateTime = widget.donatorData.data;
    String sexo = widget.donatorData.sexo.toString();
    sexo = genero(sexo);

    return MaterialApp(
      title: "Informações Doador",
      home: Scaffold(
        appBar:  AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),
          backgroundColor: const Color(0xFFD32F2F),
          elevation: 0,
          title: Row( children: <Widget> [Text('Suas informações'),
          ]),
        ),
        endDrawer: Drawer(child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFD32F2F),
            ),
            child: Text('Configurações', style: TextStyle(fontSize: 20)),
          ),
          ListTile(
            title: const Text('Alterar dados',style: TextStyle(fontSize: 20)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Sair', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              );
            }
    )
        ],
        ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                color: Color(0xFFD32F2F),
                width: 1,
              ),
                borderRadius: BorderRadius.circular(5),
               gradient: LinearGradient(
              colors: [Color(0xFFD32F2F), Colors.red],
            )),
            margin: const EdgeInsets.fromLTRB(0,15,0,15),
            alignment: Alignment.centerLeft,
            child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.mail)),
                  Text('E-mail: ' + widget.donatorData.email,
                style: TextStyle(fontSize: 20, ))])
          ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                  child: Row(
                      children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.card_membership)), Text('Nome: ' + widget.donatorData.nome,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                  child: Row(
                      children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.male)), Text('Sexo: ' + widget.donatorData.sexo,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child:Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.map)), Text('Endereço: ' + widget.donatorData.endereco,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child: Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.perm_identity)),Text('CPF: ' + widget.donatorData.cpf,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child: Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.line_weight)),Text('Peso (Kg): ' + widget.donatorData.peso,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child: Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),Text('Tipo sanguíneo: ' + widget.donatorData.tipoSangue,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child:Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.date_range)), Text('Data da última doação: ' + data,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Color(0xFFD32F2F),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFD32F2F), Colors.red],
                    )),
                margin: const EdgeInsets.fromLTRB(0,15,0,15),
                alignment: Alignment.centerLeft,
                child: Row(
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.date_range)),Text('Apto a doar a partir de: ' + data2,
                    style: TextStyle(fontSize: 20)),])
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  child: DateTimeField(
                    style: TextStyle(color: Color(0xFFD32F2F),
                        fontSize: 20),
                    format: DateFormat("dd-MM-yyyy"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2022),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return date;
                      } else {
                        return currentValue;
                      }
                    },
                    onChanged: (val) {
                      dateTime = val!;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD32F2F))),
                      labelText: "Registre sua última doação",
                      labelStyle: TextStyle(color: Color(0xFFD32F2F)),
                    ),
                  ),
                ),
              ),
              Container(

                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Color(0xFFD32F2F))),
                  child: const Text('Registrar doação',
                      textAlign: TextAlign.center),
                  onPressed: () {
                    data = formatDate(dateTime);
                    checarSexo(dateTime, widget.donatorData.sexo.toString());
                  },
                ),
              ),
              /*Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  child: const Text('Hemocentros compatíveis',
                      textAlign: TextAlign.center),
                  onPressed: () {
                    compararSangue(widget.donatorData);
                  },
                ),
              ),*/
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Color(0xFFD32F2F))),
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
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Color(0xFFD32F2F))),
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
              /*Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Text('Hemocentro' + bancos.toString()),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

void checarSexo(DateTime date, String sexo) {
  print(date);
  if (sexo == "masculino") {
    data2 = getCurrentDateM(date);
    print(data2);
  } else if (sexo == "feminino") {
    data2 = getCurrentDateF(date);
    print(data2);
  }
}
