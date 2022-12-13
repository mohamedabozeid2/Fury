import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final fun;
  final String text;
  final double height;
  final double fontSize;
  final double width;
  final Color backgroundColor;
  final double borderRadius;
  final bool isUpperCase;
  final Color textColor;

  const DefaultButton({super.key,
    required this.fun,
    required this.text,
    this.width = double.infinity,
    required this.height,
    this.backgroundColor = Colors.blue,
    required this.fontSize,
    required this.borderRadius,
    this.isUpperCase = false,
    this.textColor = Colors.black,
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        ),

      ),
    );
  }
}
