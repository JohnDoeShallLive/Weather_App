import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  final String location;
  DateTime currentTime = DateTime.now(); // New variable for time

  Worker({required this.location});

  String temp = "NA";
  String humidity = "NA";
  String air_speed = "NA";
  String description = "Can't Find Data";
  String main = "NA";
  String icon = "09d";

  // Getter for current time
  String get time => getFormattedTime();
  
  // Getter for current date
  String get date => getFormattedDate();

  // New function to get accurate time
  String getFormattedTime() {
    currentTime = DateTime.now();
    return "${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}";
  }

  // New function to get formatted date
  String getFormattedDate() {
    currentTime = DateTime.now();
    return "${currentTime.day.toString().padLeft(2, '0')}/${currentTime.month.toString().padLeft(2, '0')}/${currentTime.year}";
  }

  Future<void> getData() async {
    try {
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=880c3d28c0332bc7b0437b857f35a454&units=metric");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        // Get Temperature, Humidity
        Map<String, dynamic> tempData = data['main'];
        temp = tempData['temp'].toString();
        humidity = tempData['humidity'].toString();

        // Get Air Speed
        Map<String, dynamic> wind = data['wind'];
        double windSpeedMps = wind['speed'].toDouble();
        double windSpeedKmh = windSpeedMps * 3.6; // Convert m/s to km/h
        air_speed = windSpeedKmh.toStringAsFixed(2);

        // Get Description
        List weatherData = data['weather'];
        Map<String, dynamic> weatherMainData = weatherData[0];
        main = weatherMainData['main'];
        description = weatherMainData['description'];
        icon = weatherMainData['icon'];
      } else {
        print("Error: API responded with status code ${response.statusCode}");
        temp = "NA";
        humidity = "NA";
        air_speed = "NA";
        description = "Can't Find Data";
        main = "NA";
        icon = "09d";
      }
    } catch (e) {
      print("Exception caught: $e");
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";
    }
  }
}
