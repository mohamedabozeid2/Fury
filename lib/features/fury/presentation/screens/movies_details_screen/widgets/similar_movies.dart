import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/divider.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/similar_movie_item_builder.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../data/models/single_movie.dart';
import '../../../../data/models/single_tv.dart';
import '../../../controller/home_cubit/home_cubit.dart';
import '../../../controller/home_cubit/home_states.dart';

class SimilarMovies extends StatefulWidget {
  final dynamic movieOrTv;
  final List<SingleMovie> similarMovies;
  final List<SingleTV> similarTvShows;
  const SimilarMovies({
    required this.movieOrTv,
    required this.similarTvShows,
    required this.similarMovies,
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
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) =>
          current is LoadMoreMoviesSuccessState ||
          current is LoadMoreTvShowsSuccessState,
      listener: (context, state) {
        if (state is LoadMoreMoviesSuccessState) {
          similarDataLength = widget.similarMovies.length;
        } else if (state is LoadMoreTvShowsSuccessState) {
          similarDataLength = widget.similarTvShows.length;
        }
      },
      builder: (context, state) {
        page = widget.movieOrTv.isMovie
            ? MoviesCubit.get(context).currentSimilarMoviesPage
            : MoviesCubit.get(context).currentSimilarTVShowPage;

        similarDataLength = widget.movieOrTv.isMovie
            ? widget.similarMovies.length
            : widget.similarTvShows.length;

        if (widget.movieOrTv.isMovie) {
          if (widget.similarMovies.isNotEmpty) {
            haveSimilarData = true;
          } else {
            haveSimilarData = false;
          }
        } else {
          if (widget.similarTvShows.isNotEmpty) {
            haveSimilarData = true;
          } else {
            haveSimilarData = false;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(Helper.maxHeight * 0.005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  color: AppColors.mainColor),
              child: Text(
                widget.movieOrTv.isMovie
                    ? AppStrings.similarMovies
                    : AppStrings.similarTVShows,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            similarDataLength != 0
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
                                  movieOrTv: widget.movieOrTv.isMovie
                                      ? widget.similarMovies[index]
                                      : widget.similarTvShows[index],
                                  index: index,
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
                              widget.movieOrTv.isMovie
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
                        widget.movieOrTv.isMovie
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
