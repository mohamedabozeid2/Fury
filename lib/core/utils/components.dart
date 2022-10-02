import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Components {
  static showToast({
    required String msg,
    required fontSize,
    Color color = Colors.white,
    Color textColor = Colors.black,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: textColor,
        fontSize: fontSize);
  }

  static navigateAndFinish({required context, required widget}) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  static navigateTo(context, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
