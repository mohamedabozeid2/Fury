import 'package:flutter/material.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

class SearchItemBuilder extends StatelessWidget {
  final SingleMovie movie;

  SearchItemBuilder({
    Key? key,
    required this.movie,
  }) : super(key: key);
  late String movieName;

  @override
  Widget build(BuildContext context) {
    if (movie.name != null) {
      movieName = movie.name!;
    } else {
      movieName = movie.title!;
    }
    return GestureDetector(
      onTap: () {
        Components.scaleNavigateTo(
            context,
            MovieDetails(
              movieOrTv: movie,

            ));
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.greyColor.withOpacity(0.2)),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.s8,
            ),
            Icon(
              Icons.apps_rounded,
              color: AppColors.whiteButtonText,
            ),
            SizedBox(
              width: AppSize.s8,
            ),
            // const Spacer(),
            Expanded(
              child: Text(
                movieName,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: AppSize.s10,
            ),
            CachedImage(
              image: '${MoviesDioHelper.baseImageURL}${movie.posterPath}',
              height: Helper.maxHeight * 0.15,
              width: Helper.maxWidth * 0.3,
              circularColor: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}
