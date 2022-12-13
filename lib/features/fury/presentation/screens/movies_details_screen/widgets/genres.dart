import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';

import '../../../../../../core/utils/app_values.dart';

class Genres extends StatefulWidget {
  final List<String> genres;

  const Genres({super.key, required this.genres});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  String genresText = '';

  @override
  void initState() {
    for (int i = 0; i < widget.genres.length; i++) {
      genresText += widget.genres[i];
      if (i != widget.genres.length - 1) {
        genresText += '\n';
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Helper.maxHeight * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s5),
              color: AppColors.mainColor),
          child: Text(
            AppStrings.genre,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Helper.maxHeight * 0.01,
        ),
        // MyDivider(color: AppColors.mainColor,paddingHorizontal: Helper.getScreenWidth(context: context)*0.25),
        genresText != ""
            ? Text(
                genresText,
                style: Theme.of(context).textTheme.subtitle2,
              )
            : Text(
                AppStrings.noData,
                style: Theme.of(context).textTheme.subtitle2!,
              ),
      ],
    );
  }
}
