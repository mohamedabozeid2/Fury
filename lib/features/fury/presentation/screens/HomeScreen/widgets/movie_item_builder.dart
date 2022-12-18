import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';

class MovieItemBuilder extends StatelessWidget {
  final SingleMovie? movieModel;
  final SingleTV? tvModel;
  final bool isMovie;
  final String baseImageURL;
  final double height;
  final double width;

  const MovieItemBuilder({
    super.key,
    this.movieModel,
    this.tvModel,
    required this.isMovie,
    required this.baseImageURL,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMovie) {
          Components.navigateTo(
              context,
              MovieDetails(
                movie: movieModel,
                isMovie: true,
              ));
        } else {
          Components.navigateTo(
              context,
              MovieDetails(
                isMovie: false,
                tvShow: tvModel,
              ));
        }
        // Components.navigateTo(context, SlideAnimation(page: MovieDetails(movie: movieModel), context: context));
        // Components.navigateTo(context, MovieDetails(movie: movieModel));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
        child: CachedImage(
          image:
              '$baseImageURL${isMovie ? movieModel!.posterPath : tvModel!.posterPath}',
          height: height,
          width: width,
          fit: BoxFit.cover,
          circularColor: AppColors.mainColor,
        ),
      ),
    );
  }
}
