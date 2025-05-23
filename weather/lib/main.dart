import 'package:flutter/material.dart';
import 'Activity/home.dart';
import 'Activity/loading.dart';
import 'Activity/location.dart';
import 'Activity/saved_data_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => Location(),
      '/saved': (context) => SavedDataPage(),
    },
  ));
}
