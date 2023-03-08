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
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/widgets/divider.dart';

class SimilarMovieItemBuilder extends StatefulWidget {
  // final SingleMovie? movie;
  // final SingleTV? tvShow;
  // final bool isMovie;
  final int index;
  final dynamic movieOrTv;

  const SimilarMovieItemBuilder({
    super.key,
    // this.movie,
    // this.tvShow,
    // required this.isMovie,
    required this.index,
    required this.movieOrTv,
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
    if (widget.movieOrTv.isMovie) {
      if (widget.movieOrTv!.name != null) {
        title += widget.movieOrTv!.name!;
      } else {
        title += widget.movieOrTv!.title!;
      }
      posterPath = widget.movieOrTv!.posterPath;
    } else {
      if (widget.movieOrTv!.name != null) {
        title += widget.movieOrTv!.name!;
      } else {
        title += widget.movieOrTv!.originalName!;
      }
      posterPath = widget.movieOrTv!.posterPath;
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
              movieOrTv: widget.movieOrTv,
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
              padding: EdgeInsets.symmetric(horizontal: Helper.maxWidth * 0.03),
              child: SizedBox(
                height: Helper.maxHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.index + 1}. $title',
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    MyDivider(color: AppColors.mainColor),
                    Expanded(
                      child: Text(
                        widget.movieOrTv!.description,
                        textAlign: TextAlign.start,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    SizedBox(
                      height: Helper.maxHeight * 0.025,
                    ),
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
                            return Column(
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
                                          MoviesCubit.get(context)
                                              .addToWatchList(
                                            context: context,
                                            mediaId: widget.movieOrTv!.id,
                                            watchList: true,
                                            movieOrTv: widget.movieOrTv,
                                          );
                                        },
                                        icon: Icons.add,
                                        backgroundColor: AppColors.mainColor,
                                        spacing: AppSize.s10,
                                        iconSize: AppFontSize.s28,
                                        title: AppStrings.watchList,
                                      )
                              ],
                            );
                          },
                          listener: (context, state) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
