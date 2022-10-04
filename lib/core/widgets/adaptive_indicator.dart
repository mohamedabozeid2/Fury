import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatelessWidget {
  String os;
  Color color;

  AdaptiveIndicator({required this.os, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    if (os == 'android') {
      return CircularProgressIndicator(color: color,);
    }
    return CupertinoActivityIndicator(color: color,);
  }
}
