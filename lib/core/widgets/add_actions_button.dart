import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';

class AddActionsButton extends StatelessWidget {
  final void Function() fun;
  final IconData icon;
  final double iconSize;
  final String title;
  final Color backgroundColor;
  final double spacing;

  const AddActionsButton(
      {super.key,
      required this.fun,
      this.title = '',
      this.spacing = 0,
      this.backgroundColor = Colors.transparent,
      required this.icon,
      this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10),
      child: Row(
        children: [
          GestureDetector(
            onTap: fun,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.mainColor,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
