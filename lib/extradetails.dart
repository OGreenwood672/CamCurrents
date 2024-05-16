import 'package:flutter/material.dart';
//import 'dart:developer';

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

class UVIndexWidget extends StatelessWidget {
  final int uvIndex;

  const UVIndexWidget({
    super.key,
    required this.uvIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.lightBlue, width: 1), // Border added
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'UV: $uvIndex',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _getUVLevel(uvIndex),
            style: const TextStyle(
              color: Colors.white,
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
                    colors: [
                      _getUVColor(0), // UV level 0 color
                      _getUVColor(4), // UV level 4 color
                      _getUVColor(8), // UV level 8 color
                      _getUVColor(12), // UV level 12 color
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: (uvIndex / 12) * 150,
                child: Container(
                  width: 3, // Width of the indicator line
                  height: 14, // Height of the indicator line
                  color: Colors.white, // Color of the indicator line
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getUVColor(int uvIndex) {
    // Define color thresholds for UV index
    if (uvIndex <= 2) {
      return Colors.green; // Low UV index
    } else if (uvIndex <= 5) {
      return Colors.yellow; // Moderate UV index
    } else if (uvIndex <= 7) {
      return Colors.orange; // High UV index
    } else if (uvIndex <= 10) {
      return Colors.red; // Very high UV index
    } else {
      return Colors.purple; // Extreme UV index
    }
  }

  String _getUVLevel(int uvIndex) {
    // Define UV index levels
    if (uvIndex <= 2) {
      return 'Low'; // Low UV index
    } else if (uvIndex <= 5) {
      return 'Moderate'; // Moderate UV index
    } else if (uvIndex <= 7) {
      return 'High'; // High UV index
    } else if (uvIndex <= 10) {
      return 'Very High'; // Very high UV index
    } else {
      return 'Extreme'; // Extreme UV index
    }
  }
}

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
    // Parse sunrise time
    List<String> sunriseParts = sunriseTime!.split(':');
    int sunriseMinutes = int.parse(sunriseParts[0]) * 60 + int.parse(sunriseParts[1]);
    double stop2 = double.parse((sunriseMinutes / (24 * 60)).toStringAsFixed(3));
    // Parse sunset time
    List<String> sunsetParts = sunsetTime!.split(':');
    int sunsetMinutes = int.parse(sunsetParts[0]) * 60 + int.parse(sunsetParts[1]);
    double stop3 = double.parse((sunsetMinutes / (24 * 60)).toStringAsFixed(3));
    // Assuming currentTime represents the current time of day
    DateTime currentTime = DateTime.now();
    int currentMinutes = currentTime.hour * 60 + currentTime.minute;
    // Log sunrise and sunset times in minutes
    //log('Sunrise time (minutes): $sunriseMinutes');
    // Position the indicator line
    double indicatorPosition = currentMinutes / (24 * 60) * 150 - 1.5;

    return Container(
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
            'Sunrise: $sunriseTime', // Display sunrise time
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Sunset: $sunsetTime', // Display sunset time
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
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