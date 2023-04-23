import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

import "../main.dart";

/**
 * Classe para lidar com essa parte de background e etc;
 * Criada apenas para não termos que ficar copiando e colando essas duas/três linhas
 */
class BackgroundImage{
  String path_to_image = "assets/images/background.jpg";


  static const BoxDecoration backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/background.jpg'),
      fit: BoxFit.cover
    ),
  );
}

class DefaultTextFields{
   static Container getTextField(String label, TextEditingController controlador ){
      return Container(
        //
        margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
        color: Colors.white,
        child: TextField(
          controller: controlador,
          decoration: InputDecoration(
              labelText: label,
              contentPadding: EdgeInsets.all(10.0)
          ),
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }
}