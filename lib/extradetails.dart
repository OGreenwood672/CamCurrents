import 'package:flutter/material.dart';

class ExtraDetails extends StatelessWidget {
  const ExtraDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Set background color for additional weather conditions
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Weather Conditions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text('Wind Speed: 10 mph'), // Replace with actual wind speed value
          Text('Water Levels: Normal'), // Replace with actual water level status
          Text('UV Index: Moderate'), // Replace with actual UV index value
          Text('Sunset Time: 19:30'), // Replace with actual sunset time
        ],
      ),
    );
  }
}