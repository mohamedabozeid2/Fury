import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
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
  late int tvShowsCounter ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) => current is AddToWatchListSuccessState,
      listener: (context, state){},
      builder: (context, state){
        tvShowsCounter = moviesWatchList!.moviesList.length;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Helper.maxHeight * 0.01,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return VerticalMoviesItemBuilder(
                    moviesCounter: index+1,
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
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  tvShowsCounter += index;
                  return VerticalMoviesItemBuilder(
                    moviesCounter: tvShowsCounter+1,
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
          ),
        );
      },
    );
  }
}
