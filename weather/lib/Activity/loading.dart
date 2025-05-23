import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Pune";
  String? temp;
  String? hum;
  String? air_speed;
  String? des;
  String? main;
  String? icon;

  void startApp(String city) async {
    try {
      Worker instance = Worker(location: city);
      await instance.getData();

      if (!mounted) return;  // Check if widget is still mounted

      setState(() {
        temp = instance.temp;
        hum = instance.humidity;
        air_speed = instance.air_speed;
        des = instance.description;
        main = instance.main;
        icon = instance.icon;
      });

      if (!mounted) return;  // Check if widget is still mounted

      Future.delayed(Duration(seconds: 2), () {
        if (!mounted) return;  // Check if widget is still mounted
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          "temp_value": temp,
          "hum_value": hum,
          "air_speed_value": air_speed,
          "des_value": des,
          "main_value": main,
          "icon_value": icon,
          "city_value": city,
        });
      });
    } catch (e) {
      print("Error fetching weather data: $e");
      if (!mounted) return;
      
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not find weather data for "$city". Please try another city.'),
          duration: Duration(seconds: 3),
        ),
      );
      
      // Navigate back to home after error
      Future.delayed(Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Get search parameter if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route != null) {
        final args = route.settings.arguments;
        if (args != null && args is Map) {
          final searchText = args['searchText'];
          if (searchText != null && searchText.toString().trim().isNotEmpty) {
            setState(() {
              city = searchText.toString().trim();
            });
          }
        }
      }
      startApp(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 180),
            Image.asset("images/mlogo.png", height: 240, width: 240),
            Text(
              "Weather App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Made By Shree",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            ),
            SizedBox(height: 30),
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
