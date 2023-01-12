import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/assets_manager.dart';

class SimilarMovieItemBuilder extends StatefulWidget {
  final SingleMovie? movie;
  final SingleTV? tvShow;
  final bool isMovie;
  final int index;

  const SimilarMovieItemBuilder({
    super.key,
    this.movie,
    this.tvShow,
    required this.isMovie,
    required this.index,
  });

  @override
  State<SimilarMovieItemBuilder> createState() =>
      _SimilarMovieItemBuilderState();
}

class _SimilarMovieItemBuilderState extends State<SimilarMovieItemBuilder> {
  String title = '';
  dynamic posterPath;

  late int watchListButtonId;
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
      if (widget.tvShow!.name != null) {
        title += widget.tvShow!.name!;
      } else {
        title += widget.tvShow!.originalName!;
      }
      posterPath = widget.tvShow!.posterPath;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favoriteButtonId = -1;
    watchListButtonId = -1;
    return GestureDetector(
      onTap: () {
        Components.navigateTo(
            context,
            MovieDetails(
              isMovie: widget.isMovie,
              tvShow: widget.isMovie ? null : widget.tvShow,
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
                  width: Helper.maxWidth * 0.4,
                ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Helper.maxWidth * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.index + 1}. $title',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: Helper.maxHeight * 0.005),
                  Text(
                    widget.isMovie
                        ? widget.movie!.description
                        : widget.tvShow!.description,
                    textAlign: TextAlign.start,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: Helper.maxHeight * 0.025,
                  ),
                  Container(
                    color: Colors.yellow,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            BlocConsumer<MoviesCubit, MoviesStates>(
                              buildWhen: (previous, current) =>
                                  (current is AddToWatchListLoadingState ||
                                      current is AddToWatchListSuccessState) &&
                                  watchListButtonId == widget.index,
                              builder: (context, state) {
                                if (state is AddToWatchListSuccessState) {
                                  watchListButtonId = -1;
                                }
                                return Container(
                                  color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      state is AddToWatchListLoadingState &&
                                              watchListButtonId == widget.index
                                          ? Center(
                                              child: AdaptiveIndicator(
                                                os: Components.getOS(),
                                                color: AppColors.mainColor,
                                              ),
                                            )
                                          : AddActionsButton(
                                              fun: () {
                                                watchListButtonId = widget.index;
                                                MoviesCubit.get(context).addToWatchList(
                                                  context: context,
                                                  mediaId: widget.isMovie
                                                      ? widget.movie!.id
                                                      : widget.tvShow!.id,
                                                  isMovie: widget.isMovie,
                                                  watchList: true,
                                                );
                                              },
                                              icon: Icons.add,
                                              backgroundColor: AppColors.mainColor,
                                              spacing: AppSize.s10,
                                              iconSize: AppFontSize.s28,
                                              title: AppStrings.watchList,
                                            )
                                    ],
                                  ),
                                );
                              },
                              listener: (context, state) {},
                            ),
                          ],
                        ),
                      ],
                    ),
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
