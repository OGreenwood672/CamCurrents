import 'package:flutter/material.dart';

class WeatherTable extends StatelessWidget {
  const WeatherTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the background color to blue
      height: 220,
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
    required this.hour,
    required this.precipitation,
    required this.temperature,
    super.key,
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
              const SizedBox(height: 10),
              Column(
                children:[
                  ImageWithValueRow(
                    imagePath: 'assets/images/temperature-image-holder.png',
                    value: precipitation,
                  ),
                ]
              ),
              const SizedBox(height: 20),
              Column(
                children:[              
                  ImageWithValueRow(
                    imagePath: 'assets/images/temperature-image-holder.png',
                    value: temperature,
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

class ImageWithValueRow extends StatelessWidget {
  final String imagePath;
  final String value;

  const ImageWithValueRow({
    required this.imagePath,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 5), // Add spacing between image and text
        Center( // Center align the text
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold), // Make value bold
          ),
        ),
      ],
    );
  }
}
