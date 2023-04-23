import 'package:flutter/material.dart';

import 'shared/libs.dart';

class LoginHemocenter extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "loginhemocentro",
      home: Scaffold(
        appBar: AppBar(title: Text("Tela login hemocentro"),),
        body: Container(
          decoration: BackgroundImage.backgroundImage,
        ),
      ),
    );
  }
}