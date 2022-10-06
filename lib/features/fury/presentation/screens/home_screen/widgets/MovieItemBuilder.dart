import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/movie_model.dart';

import '../../../../../../core/utils/Colors.dart';

class MovieItemBuilder extends StatelessWidget {
  MovieModel movieModel;
  double padding;
  String baseImageURL;
  double height;
  double width;

  // double titleFontSize;
  // double dateFontSize;
  // double descriptionFontSize;

  MovieItemBuilder({
    required this.movieModel,
    required this.padding,
    required this.baseImageURL,
    required this.height,
    required this.width,
    // required this.dateFontSize,
    // required this.descriptionFontSize,
    // required this.titleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding),
      height: height,
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: CachedImage(
              image: '$baseImageURL${movieModel.posterPath}',
              height: height,
              fit: BoxFit.cover,
              circularColor: AppColors.mainColor,
              width: width,
            ),
          ),
          SizedBox(
            width: Helper.getScreenWidth(context: context) * 0.025,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          maxLines: 1,
                          movieModel.name!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white)),
                    ),
                    Text(
                      '${movieModel.rate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${movieModel.language} | Adult: ${movieModel.isAdult == false ? 'no' : 'yes'}',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.textWhiteColor,
                            ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${movieModel.releaseDate}',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColors.textWhiteColor
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${movieModel.description}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: AppColors.textWhiteColor),
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
