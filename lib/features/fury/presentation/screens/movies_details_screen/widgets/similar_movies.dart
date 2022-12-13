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
  final int movieId;
  final ScrollController scrollController;

  const SimilarMovies(
      {super.key, required this.movieId, required this.scrollController});

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  late bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page = MoviesCubit.get(context).currentSimilarMoviesPage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
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
                'Similar Movies',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            similarMovies != null
                ? Column(
                    children: [
                      SizedBox(
                        height: Helper.maxHeight * 0.01,
                      ),
                      similarMovies!.moviesList.isNotEmpty
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SimilarMovieItemBuilder(
                                  index: index,
                                  movie: similarMovies!.moviesList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return MyDivider(
                                  color: AppColors.mainColor,
                                  paddingHorizontal: 0,
                                );
                              },
                              itemCount: similarMovies!.moviesList.length,
                            )
                          : Text(
                              AppStrings.noSimilarMovies,
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
                        AppStrings.noSimilarMovies,
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
