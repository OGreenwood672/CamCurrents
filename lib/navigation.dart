
import 'package:flutter/material.dart';


Route createRoute(Widget page, Offset bgn) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: bgn, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
      // return page;
    },
  );
}
