import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';

import '../../../../../../core/utils/app_values.dart';

class SingleSettingsItemBuilder extends StatelessWidget {
  final double navigationArrowButtonSize;
  final IconData icon;
  final String title;
  final void Function() navigationFunction;
  final Color color;

  const SingleSettingsItemBuilder({
    Key? key,
    required this.navigationArrowButtonSize,
    required this.title,
    required this.navigationFunction,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigationFunction,
      child: Container(
        margin: EdgeInsets.only(
          top: AppSize.s10,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s20, vertical: AppSize.s10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                size: AppFontSize.s24,
                color: color,
              ),
            ),
            SizedBox(
              width: AppSize.s10,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: navigationArrowButtonSize,
              color: AppColors.whiteButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
