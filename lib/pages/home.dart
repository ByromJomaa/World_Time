import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // The time data
  Map data = {};

  // Helper method to open the choose_location page
  void openChooseLocationPage() async {
    // Show the loading screen
    await Navigator.pushNamed(context, "/page_loading", arguments: {
      "time": 220,
    });

    // Open the choose_location page and get the user's choice
    dynamic result = await Navigator.pushNamed(context, "/location");
    setState(() {
      data = {
        "time": result["time"],
        "location": result["location"],
        "isDaytime": result["isDaytime"],
        "flag": result["flag"]
      };
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(AssetImage("assets/day.jpg"), context);
    precacheImage(AssetImage("assets/night.jpg"), context);
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    // Set background data
    String bgImage = data["isDaytime"] ? "day.jpg" : "night.jpg";
    Color bgColor = data["isDaytime"] ? Colors.blue[900] : Colors.grey[900];

    // Set edit location button data  const Color(0xff000056)
    Color edtLocButtonColor = data["isDaytime"] ? Colors.grey[100] : Colors.grey[850];
    Color edtLocTextIconColor = data["isDaytime"] ? Colors.grey[900] : Colors.grey[300];

    // Distance between edit loc button & time
    double edtLocTimeDistance = data["isDaytime"] ? 90 : 40;

    // Top padding
    double topPadding = data["isDaytime"] ? 120 : 20;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                RaisedButton.icon(
                    onPressed: openChooseLocationPage,
                    elevation: 5,
                    icon: Icon(
                        Icons.edit_location,
                        color: edtLocTextIconColor,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                          "Edit Location",
                          style: TextStyle(
                            color: edtLocTextIconColor,
                            fontSize: 23,
                          ),
                      ),
                    ),
                  color: edtLocButtonColor,
                ),
                SizedBox(height: edtLocTimeDistance,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data["location"],
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  data["time"],
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}