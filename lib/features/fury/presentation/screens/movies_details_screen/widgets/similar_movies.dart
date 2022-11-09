import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/widgets/divider.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/similar_movie_item_builder.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/border_radius.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/helper.dart';
import '../../HomeScreen/widgets/movie_item_builder.dart';

class SimilarMovies extends StatefulWidget {
  int movieId;
  ScrollController scrollController;

  SimilarMovies({required this.movieId, required this.scrollController});

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  // ScrollController scrollController = ScrollController();
  late bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  late int page = MoviesCubit.get(context).currentSimilarMoviesPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(
                  Helper.maxHeight * 0.005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.low1),
                  color: AppColors.mainColor),
              child: Text(
                'Similar Movies',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: Helper.maxHeight * 0.01,
            ),
            if (/*MoviesCubit.get(context).*/ similarMovies!
                .moviesList.isNotEmpty)
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SimilarMovieItemBuilder(
                      index: index,
                      movie: similarMovies!.moviesList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return  MyDivider(color: AppColors.mainColor,paddingHorizontal: 0,);
                  },
                  itemCount: /*MoviesCubit.get(context)
                      .*/
                      similarMovies!.moviesList.length)
            // CategoryItemBuilder(
            //     category: CategoryKeys.similarMovies,
            //     fromSimilarMovies: true,
            //     movieID: widget.movieId,
            //     movies: MoviesCubit.get(context).similarMovies!.moviesList)
            else
              Text(
                'Sorry, There is no similar movies for this movie',
                style: Theme.of(context).textTheme.subtitle2,
              )
          ],
        );
      },
    );
  }
}
