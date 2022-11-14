import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/widgets/divider.dart';

import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/border_radius.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../domain/entities/movie_keywards.dart';

class Keywords extends StatefulWidget {
  MovieKeywords keywordsModel;

  Keywords({required this.keywordsModel});

  @override
  State<Keywords> createState() => _KeywordsState();
}

class _KeywordsState extends State<Keywords> {
  String keywords = '';

  @override
  void initState() {
    for (int i = 0; i < widget.keywordsModel.keywords.length; i++) {
      keywords += '${widget.keywordsModel.keywords[i].name}, ';
    }
    super.initState();
  }

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
            'Keywords',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Helper.maxHeight * 0.01,
        ),
        Text(
          keywords,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
