import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/Keywords.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/description.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/genres.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/rate_row.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/similar_movies.dart';

import '../../../../../core/api/movies_dio_helper.dart';
import '../../../../../core/keys/tv_category_keys.dart';
import '../../../../../core/utils/app_values.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widgets/divider.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/home_cubit/home_states.dart';
import '../HomeScreen/widgets/appbar_movie_builder.dart';
import '../../../../../core/keys/movies_category_keys.dart';

class MovieDetails extends StatefulWidget {
  final SingleMovie? movie;
  final SingleTV? tvShow;
  final bool isMovie;

  const MovieDetails(
      {super.key, this.movie, this.tvShow, required this.isMovie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late ScrollController scrollController = ScrollController();
  bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page;
  bool loadMore = false;
  late String? title;
  late String? name;
  late String? releaseDate;
  late bool? isAdult;

  @override
  void initState() {
    if (widget.isMovie == true) {
      MoviesCubit.get(context).getMovieDetailsData(movie: widget.movie!);
      title = widget.movie!.title;
      name = widget.movie!.name;
      releaseDate = widget.movie!.releaseDate;
      // keywords = MoviesCubit.get(context).movieKeywords;
      isAdult = widget.movie!.isAdult;
    } else {
      MoviesCubit.get(context).getTvDetailsData(tvShow: widget.tvShow!);
      title = widget.tvShow!.name;
      name = widget.tvShow!.originalName;
      releaseDate = widget.tvShow!.firstAirDate;
      // keywords = MoviesCubit.get(context).tvKeywords;
      isAdult = false;
    }
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
        } else {
          if (loadMore) {
            debugPrint('loading');
          } else {
            if (similarMovies != null || similarTvShows != null) {
              MoviesCubit.get(context).loadMoreMovies(
                  hasMorePages: hasNextPage,
                  isLoadingMore: isLoadingMoreRunning,
                  page: page,
                  moviesCategory: widget.isMovie
                      ? MoviesCategoryKeys.similarMovies
                      : TVCategoryKeys.similarTVShows,
                  movieID:
                      widget.isMovie ? widget.movie!.id : widget.tvShow!.id);

              page = widget.isMovie
                  ? MoviesCubit.get(context).currentSimilarMoviesPage
                  : MoviesCubit.get(context).currentSimilarTVShowPage;
            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    page = widget.isMovie
        ? MoviesCubit.get(context).currentSimilarMoviesPage
        : MoviesCubit.get(context).currentSimilarTVShowPage;
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is GetMovieDetailsSuccessState) {
          // if (widget.isMovie) {
          //   keywords = MoviesCubit.get(context).movieKeywords;
          // } else {
          //   keywords = MoviesCubit.get(context).tvKeywords;
          // }
        }
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
                        flexibleSpace: widget.isMovie
                            ? AppBarMovieBuilder(
                                isMovie: true,
                                movie: widget.movie,
                                fromMovieDetails: true,
                                image:
                                    '${MoviesDioHelper.baseImageURL}${widget.movie!.posterPath}',
                              )
                            : AppBarMovieBuilder(
                                isMovie: false,
                                tv: widget.tvShow,
                                fromMovieDetails: true,
                                image:
                                    '${MoviesDioHelper.baseImageURL}${widget.tvShow!.posterPath}',
                              ),
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
                                      RateRow(
                                          rate: widget.isMovie
                                              ? widget.movie!.rate
                                              : widget.tvShow!.voteAverage),
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
                                          child: name != null
                                              ? Text(
                                                  name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                )
                                              : Text(
                                                  title!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                )),
                                      isAdult!
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
                                    height: releaseDate != null
                                        ? Helper.maxHeight * 0.008
                                        : 0,
                                  ),
                                  releaseDate != null
                                      ? Text(
                                          '$releaseDate',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        )
                                      : Text('Release Date is unknown',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                  Text(
                                    'Language: ${widget.isMovie ? widget.movie!.language : widget.tvShow!.language}',
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
                                  Container(
                                    padding: EdgeInsets.all(
                                        Helper.maxHeight * 0.005),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s5),
                                        color: AppColors.mainColor),
                                    child: Text(
                                      'Keywords',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Helper.maxHeight * 0.01,
                                  ),
                                  if (widget.isMovie)
                                    MoviesCubit.get(context).movieKeywords !=
                                            null
                                        ? Keywords(
                                            isMovie: true,
                                            movieKeywordsModel:
                                                MoviesCubit.get(context)
                                                    .movieKeywords!,
                                          )
                                        : Text(
                                            'No data available',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                  if (widget.isMovie == false)
                                    MoviesCubit.get(context).tvKeywords != null
                                        ? Keywords(
                                            isMovie: false,
                                            tvKeywordsModel:
                                                MoviesCubit.get(context)
                                                    .tvKeywords!,
                                          )
                                        : Text(
                                            'No data available',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  Description(
                                    description: widget.isMovie
                                        ? widget.movie!.description
                                        : widget.tvShow!.description,
                                  ),
                                  MyDivider(
                                    color: AppColors.dividerColor,
                                    paddingHorizontal: 0,
                                    paddingVertical: Helper.maxHeight * 0.02,
                                  ),
                                  CachedImage(
                                    image:
                                        '${MoviesDioHelper.baseImageURL}${widget.isMovie ? widget.movie!.backDropPath : widget.tvShow!.backdropPath}',
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
                                      movieId: widget.isMovie
                                          ? widget.movie!.id
                                          : widget.tvShow!.id,
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
