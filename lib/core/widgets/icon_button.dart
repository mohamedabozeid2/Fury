import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  final fun;
  final IconData icon;
  final Color color;
  final double size;

  const DefaultIconButton({
    Key? key,
    required this.fun,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
