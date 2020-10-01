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
      "/loading": (context) => Loading(),
    },
  ));
}

// Day: <span>Photo by <a href="https://unsplash.com/@olly_allars?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">olly allars</a> on <a href="https://unsplash.com/s/photos/day-sky?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
// Night: <span>Photo by <a href="https://unsplash.com/@sanderdw?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Sander Dewerte</a> on <a href="https://unsplash.com/s/photos/night?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
