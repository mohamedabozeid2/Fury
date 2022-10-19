import 'package:flutter/material.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/category_item_builder/category_item_builder.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/category_item_builder/category_keys.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/border_radius.dart';
import '../../../../../../core/utils/helper.dart';

class SimilarMovies extends StatelessWidget {
  int movieId;

  SimilarMovies({
    required this.movieId
});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.all(Helper.getScreenHeight(context: context) * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.low1),
              color: AppColors.mainColor),
          child: Text(
            'Similar Movies',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: Helper.getScreenHeight(context: context) * 0.01,
        ),
        if (MoviesCubit.get(context).similarMovies!.moviesList.isNotEmpty)
          CategoryItemBuilder(
              category: CategoryKeys.similarMovies,
              fromSimilarMovies: true,
              movieID: movieId,
              movies: MoviesCubit.get(context).similarMovies!.moviesList)
        else
          Text(
            'Sorry, There is no similar movies for this movie',
            style: Theme.of(context).textTheme.subtitle2,
          )
      ],
    );
  }
}
