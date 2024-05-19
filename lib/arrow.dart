import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {


  final double arrowSize;
  final String direction;
  final bool visible;

  const Arrow({super.key, required this.arrowSize, required this.direction, required this.visible});

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Image.asset(
        "assets/images/${direction}arrow.gif",
        width: arrowSize,
        height: arrowSize,
      );
    } else {
      return Image.asset(
        "assets/images/empty${direction}arrow.png",
        width: arrowSize,
        height: arrowSize,
      );
    }
  }
}