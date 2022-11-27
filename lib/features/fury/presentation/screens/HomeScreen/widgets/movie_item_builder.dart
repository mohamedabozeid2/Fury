import 'package:flutter/material.dart';
import 'package:movies_application/core/animate_route/slide_transition.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';

class MovieItemBuilder extends StatelessWidget {
  SingleMovie movieModel;
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
        Components.sizeNavigateTo(context, MovieDetails(movie: movieModel));
        // Components.navigateTo(context, SlideAnimation(page: MovieDetails(movie: movieModel), context: context));
        // Components.navigateTo(context, MovieDetails(movie: movieModel));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s12)),
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
