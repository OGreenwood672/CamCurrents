import 'package:camcurrents/day.dart';
import 'package:flutter/material.dart';
//haha lol ...
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CamCurrents',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: "Rony"
      ),
      home: const Day(weatherData: null, lightingTimes: null, day: 0),
    );
  }
}

