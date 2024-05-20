import 'package:flutter/material.dart';

class SunsetTimeWidget extends StatelessWidget {
  final String? sunsetTime;
  final String? sunriseTime;

  const SunsetTimeWidget({
    super.key,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  Widget build(BuildContext context) {

    double stop2 = 0;
    double stop3 = 0;
    double indicatorPosition = 0;

    if (sunriseTime != "--:--") {
      // Parse sunrise time
      List<String> sunriseParts = sunriseTime!.split(':');

      int sunriseMinutes = int.parse(sunriseParts[0]) * 60 + int.parse(sunriseParts[1]);
      stop2 = double.parse((sunriseMinutes / (24 * 60)).toStringAsFixed(3));
      // Parse sunset time
      List<String> sunsetParts = sunsetTime!.split(':');
      int sunsetMinutes = (12 + int.parse(sunsetParts[0])) * 60 + int.parse(sunsetParts[1]);
      stop3 = double.parse((sunsetMinutes / (24 * 60)).toStringAsFixed(3));
      // Assuming currentTime represents the current time of day
      DateTime currentTime = DateTime.now();
      int currentMinutes = currentTime.hour * 60 + currentTime.minute;
      // Log sunrise and sunset times in minutes
      //log('Sunrise time (minutes): $sunriseMinutes');
      // Position the indicator line
      indicatorPosition = currentMinutes / (24 * 60) * 150 - 1.5;

    }

    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.lightBlue, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Lighting Down: $sunriseTime', // Display sunrise time
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Lighting Up: $sunsetTime', // Display sunset time
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 10, // Height of the color gradient scale
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Colors.grey, Colors.yellow,Colors.yellow, Colors.grey], // Adjust colors as needed
                    stops: [stop2 - 0.05, stop2 + 0.05, stop3 - 0.05, stop3 + 0.05], // Stops for gradient color
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: indicatorPosition,
                child: Container(
                  width: 3, // Width of the indicator line
                  height: 14, // Height of the indicator line
                  color: Colors.deepOrange, // Color of the indicator line
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}