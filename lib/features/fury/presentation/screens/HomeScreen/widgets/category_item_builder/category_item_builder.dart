import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/keys/movies_category_keys.dart';

import '../../../../../../../core/api/movies_dio_helper.dart';
import '../../../../../../../core/keys/tv_category_keys.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../data/models/single_movie.dart';
import '../../../../../data/models/single_tv.dart';
import '../../../../controller/home_cubit/home_cubit.dart';
import '../../../../controller/home_cubit/home_states.dart';
import '../movie_item_builder.dart';

class CategoryItemBuilder extends StatefulWidget {
  final String title;
  final String category;
  final bool isMovie;
  final List<SingleMovie>? movies;
  final List<SingleTV>? tv;
  final bool fromSimilarMovies;

  //// For similar movies part ////
  int? movieID;

  ////////

  CategoryItemBuilder({
    super.key,
    required this.isMovie,
    required this.title,
    required this.category,
    this.movies,
    this.tv,
    this.fromSimilarMovies = false,
    this.movieID,
    // required this.loadMoreFun,
  });

  @override
  State<CategoryItemBuilder> createState() => _CategoryItemBuilderState();
}

class _CategoryItemBuilderState extends State<CategoryItemBuilder> {
  ScrollController scrollController = ScrollController();
  bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page;

  @override
  Widget build(BuildContext context) {
    if (widget.category == MoviesCategoryKeys.popular) {
      page = MoviesCubit.get(context).currentPopularPage;
    } else if (widget.category == MoviesCategoryKeys.trending) {
      page = MoviesCubit.get(context).currentTrendingPage;
    } else if (widget.category == MoviesCategoryKeys.topRated) {
      page = MoviesCubit.get(context).currentTopRatedPage;
    } else if (widget.category == MoviesCategoryKeys.upComing) {
      page = MoviesCubit.get(context).currentUpComingPage;
    } else if (widget.category == MoviesCategoryKeys.similarMovies) {
      page = MoviesCubit.get(context).currentSimilarMoviesPage;
    } else if (widget.category == MoviesCategoryKeys.nowPlaying) {
      page = MoviesCubit.get(context).currentNowPlayingPage;
    } else if (widget.category == TVCategoryKeys.tvAiringToday) {
      page = MoviesCubit.get(context).currentTvAiringTodayPage;
    } else if (widget.category == TVCategoryKeys.similarTVShows) {
      page = MoviesCubit.get(context).currentSimilarTVShowPage;
    } else if (widget.category == TVCategoryKeys.popularTv){
      page = MoviesCubit.get(context).currentPopularTvPage;
    }

    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double movieItemWidth = Helper.maxWidth * 0.38;
        double movieDividerWidth = Helper.maxWidth * 0.07;
        double movieItemHeight = Helper.maxHeight * 0.3;
        final double movieSize = movieItemWidth + movieDividerWidth;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: Helper.maxHeight * 0.002),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Helper.maxHeight * 0.01),
                child: SizedBox(
                  height: movieItemHeight,
                  child: Row(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollUpdateNotification>(
                          onNotification: (value) {
                            setState(() {});
                            if (scrollController.position.atEdge) {
                              if (scrollController.position.pixels != 0) {
                                if (state is LoadMoreMoviesLoadingState) {
                                  debugPrint('loading');
                                } else {
                                  if (widget.isMovie) {
                                    MoviesCubit.get(context).loadMoreMovies(
                                        hasMorePages: hasNextPage,
                                        // isFirstLoad: false,
                                        isLoadingMore: isLoadingMoreRunning,
                                        page: page,
                                        moviesCategory: widget.category,
                                        movieID: widget.fromSimilarMovies
                                            ? widget.movieID
                                            : 0);
                                  } else {
                                    MoviesCubit.get(context).loadMoreTVShows(
                                        page: page,
                                        tvCategory: widget.category,
                                        hasMorePages: hasNextPage,
                                        isLoadingMore: isLoadingMoreRunning);
                                  }
                                }
                              }
                              return true;
                            } else {
                              return false;
                            }
                          },
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final double itemPosition = index * movieSize;
                              final double difference =
                                  scrollController.offset - itemPosition;
                              final double percent =
                                  1 - (difference / movieSize);
                              double opacity = percent;
                              if (opacity > 1.0) opacity = 1.0;
                              if (opacity < 0.0) opacity = 0.0;
                              double scale = percent;
                              if (scale > 1.0) scale = 1.0;
                              if (scale < 0.0) scale = 0.0;
                              return Opacity(
                                opacity: opacity,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..scale(scale + 0.1, scale + 0.1),
                                  child: widget.isMovie
                                      ? MovieItemBuilder(
                                          isMovie: widget.isMovie,
                                          movieModel: widget.movies![index],
                                          baseImageURL:
                                              MoviesDioHelper.baseImageURL,
                                          height: movieItemHeight,
                                          width: movieItemWidth,
                                        )
                                      : MovieItemBuilder(
                                          isMovie: widget.isMovie,
                                          tvModel: widget.tv![index],
                                          baseImageURL:
                                              MoviesDioHelper.baseImageURL,
                                          height: movieItemHeight,
                                          width: movieItemWidth,
                                        ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: movieDividerWidth,
                              );
                            },
                            itemCount: widget.isMovie
                                ? widget.movies!.length
                                : widget.tv!.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
