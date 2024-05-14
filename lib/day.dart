


import 'package:camcurrents/data.dart';
import 'package:camcurrents/weathertable.dart';
import 'package:flutter/material.dart';

class Day extends StatefulWidget {

  final Map<int, Map<int, Map<String, dynamic>>> _weatherData;

  const Day({super.key, required Map<int, Map<int, Map<String, dynamic>>> weatherData}) : _weatherData=weatherData;

 @override
  State<Day> createState() => _DayState(_weatherData);
}

class _DayState extends State<Day>{
  
  final Map<int, Map<int, Map<String, dynamic>>> _weatherData;

  _DayState(Map<int, Map<int, Map<String, dynamic>>> weatherData) : 
    _weatherData = weatherData;

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top section
            Container(
              color: Colors.white,
              height: 300,
              child: const Center(
                child: Text('Top Section'),
              ),
            ),
            // Middle section with the weather table
            const WeatherTable(),
            // Bottom section
            Container(
              color: Colors.white,
              height: 500,
              child: const Center(
                child: Text('Bottom Section'),
              ),
            ),
          ],
        ),
    );
  }

}