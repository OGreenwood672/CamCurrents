import 'package:flutter/material.dart';

class WaterLvlWidget extends StatelessWidget {
  final String waterLevel;
  final double width;
  final double height;

  const WaterLvlWidget({
    super.key,
    required this.waterLevel,
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
              "Water Level",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
            Text(
              waterLevel,
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