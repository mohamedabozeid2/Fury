import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';

class MovieItemBuilder extends StatelessWidget {
  final dynamic movieOrTv;
  final String baseImageURL;
  final double height;
  final double width;

  const MovieItemBuilder({
    super.key,
    required this.movieOrTv,
    required this.baseImageURL,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Components.navigateTo(
            context,
            MovieDetails(
              movieOrTv: movieOrTv,
            ));

        // Components.navigateTo(context, SlideAnimation(page: MovieDetails(movie: movieModel), context: context));
        // Components.navigateTo(context, MovieDetails(movie: movieModel));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
        child: CachedImage(
          image:
              '$baseImageURL${movieOrTv!.posterPath}',
          height: height,
          width: width,
          fit: BoxFit.cover,
          circularColor: AppColors.mainColor,
        ),
      ),
    );
  }
}
