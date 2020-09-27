import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time;     // Time in that location
  String flag;     // URL to an asset flag icon
  String url;      // Location URL for API endpoint
  bool isDaytime;  // True of false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      // Make the request
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data["datetime"];
      String offset = data["utc_offset"];

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      if(offset.startsWith("-")) {
        now = now.subtract(Duration(hours: int.parse(offset.substring(1, 3))));
      }
      else if(offset.startsWith("+")) {
        now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));
      }

      // Set the time and isDaytime properties
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print("Caught error: $e");
      time = "Could not get time data.";
    }
  }
}