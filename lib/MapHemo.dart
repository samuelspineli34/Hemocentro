import 'package:flutter/material.dart';
import 'package:hemocentro1/LoginDonator.dart';
import 'package:hemocentro1/main.dart';
import 'package:http/http.dart' as http;
import 'package:hemocentro1/donatorData.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


double latitude = 0.0;
double longitude = 0.0;

double lathemo = 0.0;
double longhemo = 0.0;

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
        appBar: AppBar(
          title: Text("Localização de Hemocentros"),
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

