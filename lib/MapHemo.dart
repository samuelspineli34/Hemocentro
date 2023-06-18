import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginDonator.dart';
import 'package:hemocentro1/hemoData.dart';
import 'package:hemocentro1/main.dart';
import 'package:http/http.dart' as http;
import 'package:hemocentro1/donatorData.dart';
import 'package:hemocentro1/RegisterHemocenter.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


double latitude = 0.0;
double longitude = 0.0;

String lathemo = generateRandomLatitude().toString();
String longhemo = generateRandomLongitude().toString();

void requestLocationPermission() async {
  PermissionStatus permissionStatus = await Permission.location.request();

  if (permissionStatus.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  } else if (permissionStatus.isDenied) {
    // A permissão foi negada pelo usuário. Você pode exibir uma mensagem informando a necessidade da permissão.
  } else if (permissionStatus.isPermanentlyDenied) {
    // A permissão foi negada permanentemente pelo usuário. Você pode exibir uma mensagem direcionando o usuário para as configurações do dispositivo para conceder a permissão manualmente.
  }
}

class MapHemo extends StatefulWidget {
  final DonatorData donatorData;

  MapHemo({required this.donatorData});

  @override
  _MapHemoState createState() => _MapHemoState(donatorData: donatorData);
}

class _MapHemoState extends State<MapHemo>
{
  final DonatorData donatorData;
  _MapHemoState({required this.donatorData});

  late Future<String> latitude;
  late Future<String> longitude;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    latitude = getCurrentLatitude();
    longitude = getCurrentLongitude();
    //lathemo = getHemocenterLatitude(donatorData.tipoSangue);
    //longhemo = getHemocenterLatitude(donatorData.tipoSangue);
  }

  Future<String> getCurrentLatitude() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position.latitude.toString();
  }

  Future<String> getCurrentLongitude() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Localização de Hemocentros Próximos",
      home: Scaffold(
        appBar:  AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.bloodtype)),
          backgroundColor: const Color(0xFFD32F2F),
          title: const Text('Localização de hemocentros'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<String>(
                future: latitude,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final lat = snapshot.data!;
                    return FutureBuilder<String>(
                      future: longitude,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final long = snapshot.data!;
                          return Container(
                            width: 500,
                            height: 500,
                            child: WebView(
                              initialUrl:
                              "https://www.google.com.br/maps/dir/$lat,$long/$lathemo,$longhemo/",
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Erro ao obter a longitude");
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Erro ao obter a latitude");
                  }
                  return CircularProgressIndicator();
                },
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Color(0xFFD32F2F))),
                    child: const Text('Voltar', textAlign: TextAlign.center),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginDonator(donatorData: donatorData),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

