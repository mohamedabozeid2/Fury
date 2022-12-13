import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/helper.dart';

class RateRow extends StatelessWidget {
  final num rate;
  const RateRow({super.key, required this.rate});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:
        Helper.maxHeight * 0.01,
        horizontal:
        Helper.maxWidth * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(AppSize.s5),
      ),
      child: Row(
        children: [
          Text(
            '$rate/10 ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Icon(
            Icons.star,
            color: AppColors.goldStarColor,
          )
        ],
      ),
    );
  }
}
