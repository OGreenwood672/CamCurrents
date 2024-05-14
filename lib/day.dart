


import 'package:camcurrents/data.dart';
import 'package:camcurrents/weathertable.dart';
import 'package:flutter/material.dart';

class Day extends StatefulWidget {

  final DateTime _date;

  const Day({super.key, required DateTime date}) : _date=date;

 @override
  State<Day> createState() => _DayState(_date);
}

class _DayState extends State<Day>{
  
  final DateTime _date;

  _DayState(DateTime date) : 
    _date = date;

  @override
  Widget build(BuildContext context) {

    var weather = fetchForecast(_date);

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