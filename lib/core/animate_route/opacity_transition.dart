import 'package:flutter/material.dart';

class OpacityAnimationNav extends PageRouteBuilder{
  final Widget page;
  BuildContext context;
  OpacityAnimationNav({required this.page , required this.context}): super(
      pageBuilder: (context, animation, animationTwo) => page,
      transitionsBuilder: (context, animation, animationTwo, child){
        return FadeTransition(opacity: animation, child: child,);
      }
  );
}