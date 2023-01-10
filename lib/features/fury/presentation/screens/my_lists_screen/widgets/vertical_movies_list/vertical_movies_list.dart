import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list_item_builder.dart';

import '../../../../../../../core/utils/Colors.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/widgets/divider.dart';

class VerticalMoviesList extends StatefulWidget {

  const VerticalMoviesList({
    Key? key,
  }) : super(key: key);

  @override
  State<VerticalMoviesList> createState() => _VerticalMoviesListState();
}

class _VerticalMoviesListState extends State<VerticalMoviesList> {
  int moviesCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Helper.maxHeight * 0.01,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            moviesCounter++;
            return VerticalMoviesItemBuilder(
              moviesCounter: moviesCounter,
              isMovie: true,
              movie: moviesWatchList!.moviesList[index],
            );
          },
          separatorBuilder: (context, index) {
            return MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            );
          },
          itemCount: moviesWatchList!.moviesList.length,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            moviesCounter++;
            return VerticalMoviesItemBuilder(
              moviesCounter: moviesCounter,
              isMovie: false,
              tv: tvShowsWatchList!.tvList[index],
            );
          },
          separatorBuilder: (context, index) {
            return MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            );
          },
          itemCount: tvShowsWatchList!.tvList.length,
        )
      ],
    );
  }
}
