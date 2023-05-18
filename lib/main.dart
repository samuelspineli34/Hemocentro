import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hemocentro1/LoginDonator.dart';
import 'package:hemocentro1/LoginHemocenter.dart';
import 'package:hemocentro1/RegisterDonate.dart';
import 'package:hemocentro1/RegisterHemocenter.dart';
import 'package:hemocentro1/donatorData.dart';
import 'package:hemocentro1/hemoData.dart';

import 'services/remote_service.dart';
import 'models/post.dart';
import 'shared/libs.dart';
import 'shared/constants.dart';
import 'package:hemocentro1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.collection("userdonate").doc("userdonate");
  FirebaseFirestore.instance.collection("userhemo").doc("userhemo");
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

const List<String> tipoUser = <String>[
  'Hemocentro',
  'Doador'
]; //tipos de usuario

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  List<AppBar> appBarContent = [
    AppBar(title: const Text('Login')),
    AppBar(title: const Text('Notícias')),
    AppBar(title: const Text('Informações')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        home: Scaffold(
            appBar: appBarContent[_currentIndex],
            //drawer: const Drawer(),
            body: IndexedStack(
                index: _currentIndex,
                children: [HomePage(), AboutPage(), InfoPage()]),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.app_registration), label: 'Login'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: 'Notícias'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info), label: 'Informações')
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? tipouser = "Hemocentro";
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              // Background
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: email,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Senha', contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: senha,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(500, 25, 500, 50),
                color: Colors.white,
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  value: tipouser,
                  hint: Text('Selecione'),
                  onChanged: (String? newValue) {
                    setState(() {
                      tipouser = newValue;
                    });
                  },
                  items: tipoUser.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text('Login', textAlign: TextAlign.center),
                  onPressed: () {
                    print("Dropdownvalue: " + tipouser.toString());
                    if (tipouser == 'Hemocentro') {
                      loginValidationHemo(email, senha, context);
                    } else if (tipouser == 'Doador') {
                      loginValidationDonator(email, senha, context);
                    }
                  },
                ),
              ),
              const Text('Primeiro acesso?',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'Criar conta doador',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterDonate()));
                      //signup screen
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Criar conta hemocentro',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterHemocenter()));
                      //signup screen
                    },
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

/**
 * criando um StatefulWidget. é necessário pois as notícias são dinâmicas
 * veja https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html para mais informações
 */
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  //usamos o ? para evitar o erro de NullSafety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
        color: Colors.red,
      ),
    );
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  //usamos o ? para evitar o erro de NullSafety

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                child: SingleChildScrollView(
                  child: Text("Titulo maneiro"),
                )),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
              child: SingleChildScrollView(
                child: Text(
                    'Ter idade entre 16 e 69 anos, desde que a primeira doação tenha sido feita até 60 anos '
                    '(menores de 18 anos devem possuir consentimento formal do responsável legal); '
                    'Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos.'
                    'Apresentar documento de identificação com foto emitido por órgão oficial '
                    '(Carteira de Identidade, Carteira Nacional de Habilitação, Carteira de Trabalho, Passaporte, Registro Nacional de Estrangeiro, '
                    'Certificado de Reservista e Carteira Profissional emitida por classe), serão aceitos documentos digitais com foto.'
                    'Pesar no mínimo 50 kg.Ter dormido pelo menos 6 horas nas últimas 24 horas.Estar alimentado. '
                    'Evitar alimentos gordurosos nas 3 horas que antecedem a doação de sangue. '
                    'Caso seja após o almoço, aguardar 2 horas.'
                    'Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos.'
                    'A frequência máxima é de quatro doações de sangue anuais para o homem e de três doações de sangue anuais para as mulher.'
                    'O intervalo mínimo entre uma doação de sangue e outra é de dois meses para os homens e de três meses para as mulheres.'),
              ),
            ),
          ]),
    );
  }
}
