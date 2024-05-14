import 'package:flutter/material.dart';

class ExtraDetails extends StatelessWidget {
  const ExtraDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set background color for additional weather conditions
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Center(
          child: Text(
            'Wind Speed: 10 km/h',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Water Levels: Val',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
           ),
          SizedBox(height: 10),
          UVIndexWidget(uvIndex: 7), // data to be changed to dynamic
          SizedBox(height: 10),
          Center(
            child: Text(
              'Sunset Time: 19:30',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
        color: _getUVColor(uvIndex),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'UV: $uvIndex',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            _getUVLevel(uvIndex),
            style: const TextStyle(
              color: Colors.white,
            ),
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