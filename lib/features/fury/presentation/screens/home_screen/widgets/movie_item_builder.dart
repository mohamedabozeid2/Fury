import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie_model.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';

class MovieItemBuilder extends StatelessWidget {
  SingleMovieModel movieModel;
  String baseImageURL;
  double height;
  double width;

  MovieItemBuilder({
    required this.movieModel,
    required this.baseImageURL,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Components.navigateTo(context, MovieDetails(movie: movieModel));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.medium2)),
        child: CachedImage(
          image: '$baseImageURL${movieModel.posterPath}',
          height: height,
          width: width,
          fit: BoxFit.cover,
          circularColor: AppColors.mainColor,
        ),
      ),
    );
  }
}
