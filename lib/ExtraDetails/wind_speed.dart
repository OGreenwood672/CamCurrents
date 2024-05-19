import 'package:flutter/material.dart';

class WindSpeedWidget extends StatelessWidget {
  final String windspeed;
  final double width;
  final double height;

  const WindSpeedWidget({
    super.key,
    required this.windspeed,
    this.width = 400, // Default width
    this.height = 100, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlue, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Wind Speed",
              style: TextStyle(
                fontSize: 18,
                //fontWeight:FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Text(
              windspeed,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}