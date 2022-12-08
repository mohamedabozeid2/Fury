import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/Keywords.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/description.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/genres.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/rate_row.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/similar_movies.dart';

import '../../../../../core/api/movies_dio_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widgets/divider.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/home_cubit/home_states.dart';
import '../HomeScreen/widgets/appbar_movie_builder.dart';
import '../../../../../core/keys/movies_category_keys.dart';

class MovieDetails extends StatefulWidget {
  final SingleMovie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late ScrollController scrollController = ScrollController();
  bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page;
  bool loadMore = false;

  @override
  void initState() {
    MoviesCubit.get(context).getMovieDetailsData(movie: widget.movie);
    scrollController.addListener(() {
      // print(scrollController.offset);
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          debugPrint('top');
        } else {
          if (loadMore) {
            debugPrint('loading');
          } else {
            MoviesCubit.get(context).loadMoreMovies(
                hasMorePages: hasNextPage,
                isLoadingMore: isLoadingMoreRunning,
                page: page,
                moviesCategory: MoviesCategoryKeys.similarMovies,
                movieID: widget.movie.id);
            page = MoviesCubit.get(context).currentSimilarMoviesPage;
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    page = MoviesCubit.get(context).currentSimilarMoviesPage;
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is LoadMoreMoviesLoadingState) {
          loadMore = true;
        } else {
          loadMore = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: state is GetMovieDetailsLoadingState
                ? Center(
                    child: AdaptiveIndicator(
                      os: Components.getOS(),
                      color: AppColors.mainColor,
                    ),
                  )
                : CustomScrollView(
                    // shrinkWrap: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        // floating: false,
                        pinned: true,
                        expandedHeight: Helper.maxHeight * 0.7,
                        flexibleSpace: AppBarMovieBuilder(
                            fromMovieDetails: true,
                            image:
                                '${MoviesDioHelper.baseImageURL}${widget.movie.posterPath}'),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(Helper.maxHeight * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RateRow(rate: widget.movie.rate),
                                      const Spacer(),
                                      AddActionsButton(
                                          fun: () {},
                                          icon: Icons.add,
                                          iconSize: AppFontSize.s26),
                                      AddActionsButton(
                                          fun: () {},
                                          icon: Icons.favorite,
                                          iconSize: AppFontSize.s26),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Helper.maxHeight * 0.03,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: widget.movie.name != null
                                              ? Text(
                                                  widget.movie.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                )
                                              : Text(
                                                  widget.movie.title!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                )),
                                      widget.movie.isAdult
                                          ? Text(
                                              '+18',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: widget.movie.releaseDate != null
                                        ? Helper.maxHeight * 0.008
                                        : 0,
                                  ),
                                  widget.movie.releaseDate != null
                                      ? Text(
                                          '${widget.movie.releaseDate}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        )
                                      : Text('Release Date is unknown',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                  Text(
                                    'Language: ${widget.movie.language}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  Genres(
                                      genres:
                                          MoviesCubit.get(context).genresList),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  MoviesCubit.get(context).keywords != null
                                      ? Keywords(
                                          keywordsModel:
                                              MoviesCubit.get(context)
                                                  .keywords!,
                                        )
                                      : Container(),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  Description(
                                      description: widget.movie.description),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  CachedImage(
                                    image:
                                        '${MoviesDioHelper.baseImageURL}${widget.movie.backDropPath}',
                                    height: Helper.maxHeight * 0.3,
                                    width: Helper.maxWidth,
                                    circularColor: AppColors.mainColor,
                                    fit: BoxFit.cover,
                                  ),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0.0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SimilarMovies(
                                      movieId: widget.movie.id,
                                      scrollController: scrollController),
                                  state is LoadMoreMoviesLoadingState
                                      ? Center(
                                          child: AdaptiveIndicator(
                                          os: Components.getOS(),
                                          color: AppColors.mainColor,
                                        ))
                                      : Container()
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
      },
    );
  }
}
