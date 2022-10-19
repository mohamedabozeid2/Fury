import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/border_radius.dart';
import '../../../../../../core/utils/helper.dart';

class Description extends StatelessWidget {
  String description;
  Description({required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.all(Helper.getScreenHeight(context: context) * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.low1),
              color: AppColors.mainColor),
          child: Text(
            'Description',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Helper.getScreenHeight(context: context) * 0.01,
        ),
        Text(description, style: Theme.of(context).textTheme.subtitle2,)
      ],
    );
  }
}
