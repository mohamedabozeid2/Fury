import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/helper.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.all(Helper.maxHeight * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s5),
              color: AppColors.mainColor),
          child: Text(
            'Description',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Helper.maxHeight * 0.01,
        ),
        Text(description, style: Theme.of(context).textTheme.subtitle2,)
      ],
    );
  }
}
