import 'package:camcurrents/getForecastAttr.dart';
import 'package:flutter/material.dart';

class WeatherTable extends StatelessWidget {

  final Map<int, dynamic>? hourlyForecast;
  final int day;

  static const double weatherCardWidth = 160;
  static const double weatherCardPadding = 8.0;

  const WeatherTable({super.key, required this.hourlyForecast, required this.day});

  @override
  Widget build(BuildContext context) {
    int currentHour = 0;
    int endHour = 23;

    int offset = 6;

    if (day == 0){
      currentHour = DateTime.now().hour;
      offset = 0;
    }

    List<int> hours = List.generate(endHour - currentHour + 1, (index) => currentHour + index);

    return Container(
      color: Colors.transparent, // Set the background color to blue
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(initialScrollOffset: offset*(weatherCardWidth+2*weatherCardPadding), keepScrollOffset: false),
        children: hours.map((hour) {
          return Padding(
            padding: const EdgeInsets.all(weatherCardPadding),
            child: WeatherCard(
              hour: hour,
              precipitation: getPrecipitation(hourlyForecast, hour), // Replace with actual value
              temperature: getTemp(hourlyForecast, hour), // Replace with actual value
              width: weatherCardWidth,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  //weather card represents each individual card (representing one hour of time)
  final int hour;
  final String precipitation;
  final String temperature;
  final double width;

  const WeatherCard({
    required this.hour,
    required this.precipitation,
    required this.temperature,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(150, 255, 255, 255),
      child: SizedBox(
        width: width, // Adjust according to your need
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$hour:00',
                  style: const TextStyle(
                    fontSize: 23, // Increase font size
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children:[              
                  ImageWithValueRow(
                    imagePath: 'assets/images/thermometer1.png',
                    value: temperature,
                  ),
                ],
              ),
              Column(
                children:[
                  ImageWithValueRow(
                    imagePath: 'assets/images/rain1.png',
                    value: precipitation,
                  ),
                ]
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
              style: const TextStyle(fontSize: 23), // Make value bold and adjust font size
              
            ),
          ),
        ),
      ],
    );
  }
}
