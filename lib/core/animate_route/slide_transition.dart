import 'package:flutter/material.dart';

class SlideAnimationNav extends PageRouteBuilder{
  final Widget page;
  BuildContext context;
  SlideAnimationNav({required this.page , required this.context}): super(
    pageBuilder: (context, animation, animationTwo) => page,
    transitionsBuilder: (context, animation, animationTwo, child){
      var begin = const Offset(1.0, 0.0);
      var end = const Offset(0.0, 0.0);
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation,child: child,);
    }
  );
}