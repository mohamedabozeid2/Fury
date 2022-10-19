import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/border_radius.dart';
import '../../../../../../core/utils/helper.dart';

class RateRow extends StatelessWidget {
  num rate;
  RateRow({required this.rate});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:
        Helper.getScreenHeight(context: context) * 0.01,
        horizontal:
        Helper.getScreenWidth(context: context) * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(AppRadius.low1),
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
