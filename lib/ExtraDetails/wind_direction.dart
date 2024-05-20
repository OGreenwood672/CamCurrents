import 'package:flutter/material.dart';

class WindDirectionWidget extends StatelessWidget {
  final String windDirection;
  final double width;
  final double height;

  const WindDirectionWidget({
    super.key,
    required this.windDirection,
    this.width = 400, // Default width
    this.height = 105, // Default height
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
              "Wind Direction",
              style: TextStyle(
                fontSize: 18,
                //fontWeight:FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Text(
              windDirection,
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