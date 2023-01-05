import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';

import '../../../../../../../core/api/movies_dio_helper.dart';
import '../../../../../../../core/utils/Colors.dart';
import '../../../../../../../core/utils/app_fonts.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../core/utils/components.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/utils/strings.dart';
import '../../../../../../../core/widgets/add_actions_button.dart';
import '../../../../../../../core/widgets/cached_image.dart';
import '../../../movies_details_screen/movie_details_screen.dart';

class VerticalMoviesItemBuilder extends StatefulWidget {
  final bool isMovie;
  final int moviesCounter;
  final SingleMovie? movie;
  final SingleTV? tv;

  const VerticalMoviesItemBuilder({
    Key? key,
    required this.isMovie,
    required this.moviesCounter,
    this.tv,
    this.movie,
  }) : super(key: key);

  @override
  State<VerticalMoviesItemBuilder> createState() =>
      _VerticalMoviesItemBuilderState();
}

class _VerticalMoviesItemBuilderState extends State<VerticalMoviesItemBuilder> {
  String title = '';
  dynamic posterPath;
  late int favoriteButtonId;

  @override
  void initState() {
    if (widget.isMovie) {
      if (widget.movie!.name != null) {
        title += widget.movie!.name!;
      } else {
        title += widget.movie!.title!;
      }
      posterPath = widget.movie!.posterPath;
    } else {
      if (widget.tv!.name != null) {
        title += widget.tv!.name!;
      } else {
        title += widget.tv!.originalName!;
      }
      posterPath = widget.tv!.posterPath;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favoriteButtonId = -1;
    return GestureDetector(
      onTap: () {
        Components.navigateTo(
            context,
            MovieDetails(
              isMovie: widget.isMovie,
              tvShow: widget.isMovie ? null : widget.tv,
              movie: widget.isMovie ? widget.movie : null,
            ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          posterPath == null
              ? Image.asset(
                  ImageAssets.emptyMovie,
                  height: Helper.maxHeight * 0.3,
                  width: Helper.maxWidth * 0.4,
                  fit: BoxFit.cover,
                )
              : CachedImage(
                  image: '${MoviesDioHelper.baseImageURL}$posterPath',
                  height: Helper.maxHeight * 0.3,
                  circularColor: AppColors.mainColor,
                  width: Helper.maxWidth * 0.4),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Helper.maxWidth * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.moviesCounter}. $title',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: Helper.maxHeight * 0.005),
                  Text(
                    widget.isMovie
                        ? widget.movie!.description
                        : widget.tv!.description,
                    textAlign: TextAlign.start,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: Helper.maxHeight * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocConsumer<MoviesCubit, MoviesStates>(
                        buildWhen: (previous, current) =>
                            (current is AddToFavoriteLoadingState ||
                                current is AddToFavoriteSuccessState) &&
                            favoriteButtonId == widget.moviesCounter,
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is AddToFavoriteSuccessState) {
                            favoriteButtonId = -1;
                          }
                          return state is AddToFavoriteLoadingState &&
                                  favoriteButtonId == widget.moviesCounter
                              ? AdaptiveIndicator(
                                  os: Components.getOS(),
                                  color: AppColors.mainColor,
                                )
                              : AddActionsButton(
                                  fun: () {
                                    favoriteButtonId = widget.moviesCounter;
                                    MoviesCubit.get(context).markAsFavorite(
                                      isMovie: widget.isMovie,
                                      context: context,
                                      fromFavoriteScreen: true,
                                      mediaId: widget.isMovie
                                          ? widget.movie!.id
                                          : widget.tv!.id,
                                      favorite: false,
                                    );
                                  },
                                  icon: Icons.favorite,
                                  iconSize: AppFontSize.s28,
                                  title: AppStrings.unFavorite,
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
