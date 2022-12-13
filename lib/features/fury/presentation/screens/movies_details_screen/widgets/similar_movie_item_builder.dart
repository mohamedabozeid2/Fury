import 'package:flutter/material.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';

import '../../../../../../core/utils/assets_manager.dart';

class SimilarMovieItemBuilder extends StatefulWidget {
  final SingleMovie movie;
  final int index;

  const SimilarMovieItemBuilder({super.key, required this.movie, required this.index});

  @override
  State<SimilarMovieItemBuilder> createState() =>
      _SimilarMovieItemBuilderState();
}

class _SimilarMovieItemBuilderState extends State<SimilarMovieItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.movie.posterPath == null
            ? Image.asset(
                ImageAssets.emptyMovie,
                height: Helper.maxHeight * 0.3,
                width: Helper.maxWidth * 0.4,
                fit: BoxFit.cover,
              )
            : CachedImage(
                image: '${MoviesDioHelper.baseImageURL}${widget.movie.posterPath}',
                height: Helper.maxHeight * 0.3,
                width: Helper.maxWidth * 0.4),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.all(Helper.maxWidth * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.index + 1}. ${widget.movie.name ?? widget.movie.title}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                    height: Helper.maxHeight * 0.005),
                Text(
                  widget.movie.description,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: Helper.maxHeight*0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddActionsButton(
                      fun: () {},
                      icon: Icons.add,
                      iconSize: AppFontSize.s28,
                      title: AppStrings.later,
                    ),
                    AddActionsButton(
                      fun: () {},
                      icon: Icons.favorite,
                      iconSize: AppFontSize.s28,
                      title: AppStrings.favorite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
