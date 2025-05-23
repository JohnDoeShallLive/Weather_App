import 'package:flutter/material.dart';
import '../database_helper.dart';

class SavedDataPage extends StatefulWidget {
  const SavedDataPage({super.key});

  @override
  _SavedDataPageState createState() => _SavedDataPageState();
}

class _SavedDataPageState extends State<SavedDataPage> {
  late Future<List<Map<String, dynamic>>> _savedData;

  @override
  void initState() {
    super.initState();
    _savedData = DatabaseHelper.instance.queryAllRows();
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Weather Data"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _savedData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No saved data found."));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ListTile(
                  leading: Image.network(
                    "http://openweathermap.org/img/wn/${item['icon']}@2x.png",
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    "${item['city']} - ${item['main']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Temp: ${item['temperature']} °C\nHumidity: ${item['humidity']}%\nAir Speed: ${item['air_speed']} km/hr\nDesc: ${item['description']}\nDate: ${item['date']} Time: ${item['time']}"),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

