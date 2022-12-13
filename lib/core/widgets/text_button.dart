import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final fun;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  const DefaultTextButton({super.key,
    required this.text,
    required this.fun,
    required this.fontSize,
    this.textColor = Colors.blue,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: fun,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ));
  }
}
