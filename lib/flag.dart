


import 'package:flutter/material.dart';

class Flag extends StatelessWidget {


  final double flagSize;
  final String flag;

  const Flag({super.key, required this.flagSize, required this.flag});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/${flag}flag.png",
      width: flagSize,
      height: flagSize,
    );
  }

}