import 'package:flutter/material.dart';

class SizeAnimationNav extends PageRouteBuilder{
  final Widget page;
  BuildContext context;
  SizeAnimationNav({required this.page , required this.context}): super(
      pageBuilder: (context, animation, animationTwo) => page,
      transitionsBuilder: (context, animation, animationTwo, child){
        return Align(child: SizeTransition(sizeFactor: animation,child: child,),);
      }
  );
}