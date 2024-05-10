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
                precipitation: 'PrcpVal', // Replace with actual value
                temperature: 'TempVal', // Replace with actual value
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$hour:00',
                style: const TextStyle(
                  fontSize: 18, // Increase font size
                  fontWeight: FontWeight.bold, // Make it bold
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/temperature-image-holder.png', // Path to temperature image
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 5), // Add spacing between image and text
                      Text(
                        precipitation,
                        style: const TextStyle(fontWeight: FontWeight.bold), // Make value bold
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/temperature-image-holder.png', // Path to temperature image
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 5), // Add spacing between image and text
                      Text(
                        temperature,
                        style: const TextStyle(fontWeight: FontWeight.bold), // Make value bold
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}