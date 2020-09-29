import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/page_loading.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigo[900],
      accentColor: Colors.indigoAccent,
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.grey[300]),
          bodyText2: TextStyle(color: Colors.grey[900]),
      ),
    ),
    initialRoute: "/",
    routes: {
      "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/location": (context) => ChooseLocation(),
      "/page_loading": (context) => PageLoading(),
    },
  ));
}