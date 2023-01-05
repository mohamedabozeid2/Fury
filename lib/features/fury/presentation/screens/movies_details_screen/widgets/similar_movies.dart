import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/divider.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/similar_movie_item_builder.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../controller/home_cubit/home_cubit.dart';
import '../../../controller/home_cubit/home_states.dart';

class SimilarMovies extends StatefulWidget {
  final bool isMovie;

  const SimilarMovies({
    required this.isMovie,
    super.key,
  });

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  late bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page;
  late bool haveSimilarData;
  late int similarDataLength;

  @override
  void initState() {
    if (widget.isMovie) {
      page = MoviesCubit.get(context).currentSimilarMoviesPage;
      if (similarMovies!.moviesList.isNotEmpty) {
        haveSimilarData = true;
      } else {
        haveSimilarData = false;
      }
      similarDataLength = similarMovies!.moviesList.length;
    } else {
      page = MoviesCubit.get(context).currentSimilarTVShowPage;
      if (similarTvShows!.tvList.isNotEmpty) {
        haveSimilarData = true;
      } else {
        haveSimilarData = false;
      }
      similarDataLength = similarTvShows!.tvList.length;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) => current is LoadMoreMoviesSuccessState,
      listener: (context, state) {
        if (state is LoadMoreMoviesSuccessState) {
          similarDataLength = similarMovies!.moviesList.length;
        } else if (state is LoadMoreTvShowsSuccessState) {
          similarDataLength = similarTvShows!.tvList.length;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(Helper.maxHeight * 0.005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  color: AppColors.mainColor),
              child: Text(
                widget.isMovie
                    ? AppStrings.similarMovies
                    : AppStrings.similarTVShows,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            similarMovies != null || similarTvShows != null
                ? Column(
                    children: [
                      SizedBox(
                        height: Helper.maxHeight * 0.01,
                      ),
                      haveSimilarData
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SimilarMovieItemBuilder(
                                  isMovie: widget.isMovie,
                                  index: index,
                                  movie: widget.isMovie
                                      ? similarMovies!.moviesList[index]
                                      : null,
                                  tvShow: widget.isMovie == false
                                      ? similarTvShows!.tvList[index]
                                      : null,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return MyDivider(
                                  color: AppColors.mainColor,
                                  paddingHorizontal: 0,
                                );
                              },
                              itemCount: similarDataLength,
                            )
                          : Text(
                              widget.isMovie
                                  ? AppStrings.noSimilarMovies
                                  : AppStrings.noSimilarTVShows,
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: Helper.maxHeight * 0.01,
                      ),
                      Text(
                        widget.isMovie
                            ? AppStrings.noSimilarMovies
                            : AppStrings.noSimilarTVShows,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
