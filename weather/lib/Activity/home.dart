import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../Worker/worker.dart';
import '../database_helper.dart';  // Import DB helper

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Worker worker;
  late Timer timer; //timer for updating time

  @override
  void initState() {
    super.initState();
    worker = Worker(location: "London"); // Initialize with any location
    // Update time every second
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // This will rebuild the widget every second
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> _saveData(Map info) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(DatabaseHelper.table, {
      DatabaseHelper.columnTemp: info['temp_value'] ?? "NA",
      DatabaseHelper.columnAirSpeed: info['air_speed_value'] ?? "NA",
      DatabaseHelper.columnHumidity: info['hum_value'] ?? "NA",
      DatabaseHelper.columnDescription: info['desc_value'] ?? "NA",
      DatabaseHelper.columnMain: info['main_value'] ?? "NA",
      DatabaseHelper.columnIcon: info['icon_value'] ?? "09d",
      DatabaseHelper.columnCity: info['city_value'] ?? "NA",
      DatabaseHelper.columnTime: worker.time,
      DatabaseHelper.columnDate: worker.date,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Weather data saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    String temp = info?['temp_value']?.toString() ?? "NA";
    String air = info?['air_speed_value']?.toString() ?? "NA";
    String hum = info?['hum_value']?.toString() ?? "NA";
    String desc = info?['desc_value']?.toString() ?? "NA";
    String main = info?['main_value']?.toString() ?? "NA";
    String icon = info?['icon_value']?.toString() ?? "09d";
    String getcity = info?['city_value']?.toString() ?? "NA";

    if (temp != "NA") {
      temp = temp.substring(0, 4);
      air = air.substring(0, 4);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Weather Home"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue[200]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save Weather Data',
            onPressed: () {
              if (info != null) {
                _saveData(info);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No data to save')),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            tooltip: 'View Saved Data',
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[800]!, Colors.blue[300]!]
                )
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          padding: EdgeInsets.all(10),
                          child: Row(children: [
                            Image.network(
                                "http://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  worker.time,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  worker.date,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoxedIcon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  temp,
                                  style: TextStyle(fontSize: 75),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )

                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [BoxedIcon(WeatherIcons.day_windy)],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "$air",
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("km/hr")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [BoxedIcon(WeatherIcons.humidity)],
                            ),
                            SizedBox(height: 30),
                            Text(
                              hum,
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Shree"),
                      Text("Data Provided By Openweathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
