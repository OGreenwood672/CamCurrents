import 'package:flutter/material.dart';

class WeatherTable extends StatelessWidget {
  const WeatherTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the background color to blue
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            12, // next 12 hours
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeatherCard(
                hour: index,
                precipitation: 'Precip_Value', // Replace with actual value
                temperature: 'Temp_Value', // Replace with actual value
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final int hour;
  final String precipitation;
  final String temperature;

  const WeatherCard({
    super.key,
    required this.hour,
    required this.precipitation,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150, // Adjust according to your need
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$hour:00'),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/temperature-image-holder.png', // Path to precipitation image
                  //   width: 50,
                  //   height: 50,
                  // ),
                  const Text('Precipitation'),
                  Text(precipitation), // Replace with actual value
                ],
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/temperature-image-holder.png', // Path to temperature image
                  //   width: 50,
                  //   height: 50,
                  // ),
                  const Text('Temperature'),
                  Text(temperature), // Replace with actual value
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}