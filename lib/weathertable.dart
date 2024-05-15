import 'package:flutter/material.dart';

class WeatherTable extends StatelessWidget {

  final Map<int, dynamic>? hourlyForecast;

  const WeatherTable({super.key, required this.hourlyForecast});

  String getPrecipitation(int time) {
    if (hourlyForecast == null) {
      return "-%";
    }
    return "${hourlyForecast?[time]["precipitation"]}%";
  }

  String getTemp(int time) {
    if (hourlyForecast == null) {
      return "-°C";
    }
    return "${hourlyForecast?[time]["temperature"]}°C";
  }

  @override
  Widget build(BuildContext context) {
    int currentHour = DateTime.now().hour;
    int endHour = currentHour + 12;
    if (endHour > 23) {
      endHour = 23; // Ensure it doesn't exceed 23:00
    }
    List<int> hours = List.generate(endHour - currentHour + 1, (index) => currentHour + index);

    return Container(
      color: Colors.transparent, // Set the background color to blue
      height: 220,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: hours.map((hour) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeatherCard(
                hour: hour,
                precipitation: getPrecipitation(hour), // Replace with actual value
                temperature: getTemp(hour), // Replace with actual value
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  //weather card represents each individual card (representing one hour of time)
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
                    imagePath: 'assets/images/precip-image.png',
                    value: precipitation,
                  ),
                ]
              ),
              const SizedBox(height: 10),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            width: 40,
            height: 60,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(width: 5), // Add spacing between image and text
        Expanded(
          child: Center( // Center align the text
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Make value bold and adjust font size
              
            ),
          ),
        ),
      ],
    );
  }
}
