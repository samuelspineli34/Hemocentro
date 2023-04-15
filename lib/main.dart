import 'package:flutter/material.dart';

void main() => runApp(MainPage());

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

const List<String> list = <String>['Hemocentro', 'Doador']; //tipos de usuario

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            alignment: Alignment.center,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    );
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<AppBar> appBarContent = [
    AppBar(title: const Text('Login')),
    AppBar(title: const Text('Notícias')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        home: Scaffold(
            appBar: appBarContent[_currentIndex],
            //drawer: const Drawer(),
            body: IndexedStack(
                index: _currentIndex, children: [HomePage(), AboutPage()]),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.app_registration), label: 'Login'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      labelText: 'ID', contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Senha', contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  obscureText: true,
                ),
              ),
              DropdownButtonExample(), //Lista com tipos de acesso
              Container(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text('Login', textAlign: TextAlign.center),
                  onPressed: () {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Primeiro acesso?',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
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

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            // Background
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          width: 500,
          height: 500,
          margin: EdgeInsets.all(50.0),
          color: Colors.grey,
          child: const Text('Notícias', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
