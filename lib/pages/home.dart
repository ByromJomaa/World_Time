import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // The time data
  Map data = {};
  Map newData = {};

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  // Helper method to open the choose_location page
  void openChooseLocationPage() async {
    // Show the loading screen
    // await Navigator.pushNamed(context, "/page_loading", arguments: {
    //   "time": 220,
    // });

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

  void _onRefresh() async {
    // newData = {
    //   "url": data["url"],
    //   "location": data["location"],
    //   "flag": data["flag"]
    // };
    //
    // WorldTime instance = WorldTime(url: newData["url"], location: newData["location"], flag: newData["flag"]);
    // await Future.delayed(Duration(seconds: 1));
    // await instance.getTime();
    //
    // data["time"] = newData["time"];
    // data["isDaytime"] = newData["isDaytime"];

    // Open the choose_location page and get the user's choice
    await Navigator.pushNamed(context, "/loading");

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
    print("hello 2");
    _refreshController.loadComplete();
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
        child: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          // footer: CustomFooter(
          //   builder: (BuildContext context, LoadStatus mode) {
          //     Widget body;
          //     if(mode==LoadStatus.idle){
          //       body = Text("pull up load");
          //     }
          //     else if(mode==LoadStatus.loading){
          //       body = CupertinoActivityIndicator();
          //     }
          //     else if(mode == LoadStatus.failed){
          //       body = Text("Load Failed!Click retry!");
          //     }
          //     else if(mode == LoadStatus.canLoading){
          //       body = Text("release to load more");
          //     }
          //     else{
          //       body = Text("No more Data");
          //     }
          //     return Container(
          //       height: 55.0,
          //       child: Center(child:body),
          //     );
          //   },
          // ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
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
      ),
    );
  }
}