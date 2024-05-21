import 'package:flutter/material.dart';

class HumidityWidget extends StatelessWidget {
  final String humidity;
  final double width;
  final double height;

  const HumidityWidget({
    super.key,
    required this.humidity,
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
            Text(
              "Humidity",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.white70,
              ),
            ),
            Text(
              humidity,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}