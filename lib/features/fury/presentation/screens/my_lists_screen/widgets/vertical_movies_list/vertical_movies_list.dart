import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list_item_builder.dart';

import '../../../../../../../core/utils/Colors.dart';
import '../../../../../../../core/utils/components.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/widgets/adaptive_indicator.dart';
import '../../../../../../../core/widgets/divider.dart';

class VerticalMoviesList extends StatefulWidget {
  // final List myListMoves;

  const VerticalMoviesList({
    Key? key,
    // required this.myListMoves,
  }) : super(key: key);

  @override
  State<VerticalMoviesList> createState() => _VerticalMoviesListState();
}

class _VerticalMoviesListState extends State<VerticalMoviesList> {
  int tvShowsCounter = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) =>
      current is AddToWatchListSuccessState ||
          current is LoadMoreWatchListLoadingState ||
          current is LoadMoreWatchListSuccessState,
      listener: (context, state) {},
      builder: (context, state) {
        tvShowsCounter = 0;
        return Column(
          children: [
            SizedBox(
              height: Helper.maxHeight * 0.01,
            ),
            // ListView.separated(itemBuilder: (context, index) {
            //   return
            // }, separatorBuilder: (context, index) {
            //   return MyDivider(
            //     color: AppColors.mainColor,
            //     paddingHorizontal: 0,
            //   );
            // }
            //     , itemCount: widget.myListMoves.length
            // )
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                tvShowsCounter++;
                return VerticalMoviesItemBuilder(
                  moviesCounter: tvShowsCounter,
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
            MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            ),
            MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            ),
            Text("DIVIDER HERE BRO"),
            MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            ),
            MyDivider(
              color: AppColors.mainColor,
              paddingHorizontal: 0,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // tvShowsCounter =moviesWatchList!.moviesList.length +  index;
                tvShowsCounter++;
                return VerticalMoviesItemBuilder(
                  moviesCounter: tvShowsCounter,
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
            ),
            state is LoadMoreWatchListLoadingState
                ? AdaptiveIndicator(
              os: Components.getOS(),
              color: AppColors.mainColor,
            )
                : Container(),
            const SizedBox(
              height: 50,
            ),
          ],
        );
      },
    );
  }
}
