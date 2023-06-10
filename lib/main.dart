import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hemocentro1/RegisterDonate.dart';
import 'package:hemocentro1/ResetPassword.dart';
import 'package:hemocentro1/RegisterHemocenter.dart';
import 'package:hemocentro1/donatorData.dart';
import 'package:hemocentro1/hemoData.dart';
import 'package:hemocentro1/MapHemo.dart';

import '../services/remote_service.dart';
import '../models/post.dart';
import 'package:hemocentro1/firebase_options.dart';

//flutter build appbundle
//flutter run --multidex
//flutter --web-renderer html
//Usar versão android 12.0 no emulador

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
        theme: ThemeData(primaryColorDark: Colors.red),
        initialRoute: '/',
        routes: {
          '/noticias': (context) => AboutPage(),
          '/info': (context) => InfoPage(),
          '/registro_doador': (context) => RegisterDonate(),
          '/registro_hemocentro': (context) => RegisterHemocenter(),
          '/mapa': (context) => MapHemo(),
        },
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
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.redAccent[700],
          ),
          child: SingleChildScrollView (
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(80, 30, 80, 0),
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
                margin: const EdgeInsets.fromLTRB(80, 50, 80, 50),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    contentPadding: EdgeInsets.all(10.0),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: senha,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(80, 0, 80, 50),
                alignment: Alignment.center,
                color: Colors.white,
                child: DropdownButton<String>(
                  autofocus: true,
                  alignment: Alignment.center,
                  focusColor: Colors.white60,
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
                      alignment: Alignment.center,
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                child: ElevatedButton(
                    child: const Text('Login', textAlign: TextAlign.center),
                    onPressed: () {
                      print("Dropdownvalue: " + tipouser.toString());
                      if (tipouser == 'Hemocentro') {
                        loginValidationHemo(email, senha, context);
                      } else if (tipouser == 'Doador') {
                        loginValidationDonator(email, senha, context);
                      }
                    }),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                        TextButton(
                          child: const Text('Primeiro acesso?',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center),
                          onPressed: ()=> {}
                        ),
                        TextButton(
                          child: const Text(
                              'Esqueceu senha?',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                            //signup screen
                          },
                        ),
                  ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  )
                ],
              ),
            ],
          ),
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
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoaded
          ? CarouselSlider(
        items: toListWidget(),
        options: CarouselOptions(
          height: 400,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      )
          : CircularProgressIndicator(),
    );
  }

  /**
   * Usa a classe  response_service para pegar os posts da api
   */
  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      //coisa do StatefulWidget, basicamente reconstroi a tela
      setState(() {
        isLoaded = true;
      });
    }
  }

  /* Transforma os jsons obtidos do getData() e transforma eles em
  Widgets; isso é necessário para o Carousel, que  precisa de uma lista de Widgets para funcionar
  */
  List<Widget> toListWidget() {

    print(posts![0].thumbnailUrl);

    final widgets = List<Widget>.filled(4, SizedBox.shrink());

    for (int i = 0; i < 4; i++) {
      widgets[i] = Container(
        child: ListView(
          children: [
            Title(
              color: Colors.blueGrey,
              child: Text(posts![i].title),
            ),
            Image(
              image: NetworkImage(posts![i].thumbnailUrl),
            ),
          ],
        ),
      );
    }
    return widgets;
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
        child: SingleChildScrollView (
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: SingleChildScrollView(
                  child: Text("Requisitos para realizar a doação de sangue", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                )),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Text(
                    'Ter idade entre 16 e 69 anos, desde que a primeira doação tenha sido feita até 60 anos '
                    '(menores de 18 anos devem possuir consentimento formal do responsável legal).\n'
                    'Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos.\n'
                    'Apresentar documento de identificação com foto emitido por órgão oficial '
                    '(Carteira de Identidade, Carteira Nacional de Habilitação, Carteira de Trabalho, Passaporte, Registro Nacional de Estrangeiro, '
                    'Certificado de Reservista e Carteira Profissional emitida por classe), serão aceitos documentos digitais com foto.\n'
                    'Pesar no mínimo 50 kg.\nTer dormido pelo menos 6 horas nas últimas 24 horas. Estar alimentado. \n'
                    'Evitar alimentos gordurosos nas 3 horas que antecedem a doação de sangue. '
                    'Caso seja após o almoço, aguardar 2 horas.\n'
                    'Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos.\n'
                    'A frequência máxima é de quatro doações de sangue anuais para o homem e de três doações de sangue anuais para as mulher.\n'
                    'O intervalo mínimo entre uma doação de sangue e outra é de dois meses para os homens e de três meses para as mulheres.\n',
                    style: const TextStyle(fontSize: 20)),
              ),
            ),
          ]),
        ),
    );
  }
}
