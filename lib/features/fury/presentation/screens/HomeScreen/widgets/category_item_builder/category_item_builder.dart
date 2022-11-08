import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/widgets/category_item_builder/category_keys.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';

import '../../../../../../../core/api/dio_helper.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../data/models/single_movie_model.dart';
import '../movie_item_builder.dart';

class CategoryItemBuilder extends StatefulWidget {
  String? title;
  String category;
  List<SingleMovieModel> movies;
  bool fromSimilarMovies;

  //// For similar movies part ////
  int? movieID;

  ////////

  CategoryItemBuilder({
    this.title,
    required this.category,
    required this.movies,
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
    if (widget.category == CategoryKeys.popular) {
      page = MoviesCubit.get(context).currentPopularPage;
    } else if (widget.category == CategoryKeys.trending) {
      page = MoviesCubit.get(context).currentTrendingPage;
    } else if (widget.category == CategoryKeys.topRated) {
      page = MoviesCubit.get(context).currentTopRatedPage;
    } else if (widget.category == CategoryKeys.upComing) {
      page = MoviesCubit.get(context).currentUpComingPage;
    } else if (widget.category == CategoryKeys.similarMovies) {
      page = MoviesCubit.get(context).currentSimilarMoviesPage;
    }

    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: Helper.getScreenHeight(context: context) * 0.002),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != null
                  ? Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Helper.getScreenHeight(context: context) * 0.01),
                child: Container(
                  height: Helper.getScreenHeight(context: context) * 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollEndNotification>(
                          onNotification: (value) {
                            if (scrollController.position.atEdge) {
                              if (scrollController.position.pixels != 0) {
                                if (state is LoadMoreMoviesLoadingState) {
                                  debugPrint('loading');
                                } else {
                                  MoviesCubit.get(context).loadMoreMovies(
                                      hasMorePages: hasNextPage,
                                      // isFirstLoad: false,
                                      isLoadingMore: isLoadingMoreRunning,
                                      page: page,
                                      moviesCategory: widget.category,
                                      movieID: widget.fromSimilarMovies
                                          ? widget.movieID
                                          : 0);
                                }
                              }
                              return true;
                            } else {
                              return false;
                            }
                          },
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MovieItemBuilder(
                                  movieModel: widget.movies[index],
                                  baseImageURL: DioHelper.baseImageURL,
                                  height:
                                      Helper.getScreenHeight(context: context) *
                                          0.2,
                                  width:
                                      Helper.getScreenWidth(context: context) *
                                          0.3,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 7.0,
                                );
                              },
                              itemCount: widget.movies
                                  .length /*trendingMovies!
                                .moviesList.length*/
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
