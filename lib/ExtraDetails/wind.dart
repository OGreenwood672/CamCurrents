import 'package:flutter/material.dart';

class WindWidget extends StatelessWidget {
  final String windspeed;
  final String windDirection;
  final double width;
  final double height;

  const WindWidget({
    super.key,
    required this.windspeed,
    required this.windDirection,
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
              "Wind",
              style: TextStyle(
                fontSize: 20,
                //fontWeight:FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              windspeed,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              windDirection,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}