import 'package:flutter/material.dart';

class RotationAnimationNav extends PageRouteBuilder {
  final Widget page;
  BuildContext context;

  RotationAnimationNav({required this.page, required this.context})
      : super(
      pageBuilder: (context, animation, animationTwo) => page,
      transitionsBuilder: (context, animation, animationTwo, child) {
        var begin = 0.0;
        var end = 1.0;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
        CurvedAnimation(parent: animation, curve: Curves.linear);
        return RotationTransition(
          turns: tween.animate(curveAnimation),
          child: child,
        );
      });
}
