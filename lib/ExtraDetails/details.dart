import 'package:camcurrents/ExtraDetails/sun.dart';
import 'package:camcurrents/ExtraDetails/uv.dart';
import 'package:flutter/material.dart';

class ExtraDetails extends StatelessWidget {
  const ExtraDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 74, 126), // Set background color for additional weather conditions
      //color: Colors.transparent,
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Center(
          child: Text(
            'Wind Speed: 10 km/h', //to change to dynamic
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Water Level:   0.70m', //to change to dynamic
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
           ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: UVIndexWidget(uvIndex: 7), // data to be changed to dynamic
              ),
              SizedBox(width: 20), // Adjust spacing between widgets
              Flexible(
                child: SunsetTimeWidget(sunriseTime: "06:14", sunsetTime: "20:16"), // data to be changed to dynamic
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}