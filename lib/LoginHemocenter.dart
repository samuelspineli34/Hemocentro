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
        endDrawer: Drawer(child: ListView(
          // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
        const DrawerHeader(
        decoration: BoxDecoration(
        color: Color(0xFFD32F2F),
        ),
        child: Text('Configurações',style: TextStyle(fontSize: 20)),
      ),
        ListTile(
          title: const Text('Alterar dados',style: TextStyle(fontSize: 20)),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
            title: const Text('Sair',style: TextStyle(fontSize: 20)),
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
        appBar:  AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),
          backgroundColor: const Color(0xFFD32F2F),
          title: const Text('Informações do hemocentro'),
          elevation: 0,
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
                        Text('E-mail: ' + hemoData.email,
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.card_membership)), Text('Nome: ' + hemoData.nome,
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.map)), Text('Endereço: ' + hemoData.endereco,
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.perm_identity)),Text('CNPJ: ' + hemoData.cnpj,
                            style: TextStyle(fontSize: 20)),])
              ),
              Text('Tipos sanguíneos necessitados: ', style: TextStyle(fontSize: 20)),
              Container (
                padding: EdgeInsets.fromLTRB(130, 5, 150, 0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tiposSangue.length,
                itemBuilder: (BuildContext context, int index) {
                  final tipoSangue = tiposSangue[index];
                  final isChecked = tiposSangueSelecionados.contains(tipoSangue);

                  return CheckboxListTile(
                    activeColor: Color(0xFFD32F2F),
                    title: Text(tipoSangue, style: TextStyle(fontSize: 20)),
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
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD32F2F))),
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






