import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageLoading extends StatefulWidget {
  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {

  Map data;
  int time = 300;


  void popPage() async {
   if (time == 220) {
      await Future.delayed(const Duration(milliseconds: 220), () async {
        Navigator.pop(context);
      });
    }
    else {
      await Future.delayed(const Duration(milliseconds: 320), () async {
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    popPage();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    //time = int.parse(data["time"]);

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}