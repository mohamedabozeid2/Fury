import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/widgets/appbar_movie_builder.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/widgets/category_item_builder/category_item_builder.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/widgets/category_item_builder/category_keys.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';

import '../../../../../core/api/dio_helper.dart';
import '../../../../../core/utils/Colors.dart';
import '../../../../../core/utils/border_radius.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../core/widgets/adaptive_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int randomPosterNumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomPosterNumber = Random().nextInt(19);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetAllMoviesLoadingState
            ? Center(
                child: AdaptiveIndicator(
                os: Components.getOS(),
                color: AppColors.mainColor,
              ))
            : CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppRadius.large1),
                            color: AppColors.mainColor,
                          ),
                          child: Image(
                            image: const AssetImage('assets/images/logo.png'),
                            height:
                                Helper.getScreenHeight(context: context) * 0.05,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(
                                Helper.getScreenHeight(context: context) *
                                    0.01),
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.large1)),
                            child: const Icon(Icons.search),
                          ),
                        )
                      ],
                    ),
                    // pinned: true,
                    expandedHeight:
                        Helper.getScreenHeight(context: context) * 0.7,
                    flexibleSpace: AppBarMovieBuilder(
                        movie: trendingMovies!.moviesList[randomPosterNumber],
                        image:
                            '${DioHelper.baseImageURL}${trendingMovies!.moviesList[randomPosterNumber].posterPath}'),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              Helper.getScreenHeight(context: context) * 0.01,
                          vertical:
                              Helper.getScreenHeight(context: context) * 0.04),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryItemBuilder(
                                  title: AppStrings.upComingMovies,
                                  movies: upComingMovies!.moviesList,
                                  category: CategoryKeys.upComing,
                                ),
                                CategoryItemBuilder(
                                  title: AppStrings.trendingMovies,
                                  movies: trendingMovies!.moviesList,
                                  category: CategoryKeys.trending,
                                ),
                                CategoryItemBuilder(
                                  title: AppStrings.popularMovies,
                                  movies: popularMovies!.moviesList,
                                  category: CategoryKeys.popular,
                                ),
                                CategoryItemBuilder(
                                  title: AppStrings.topRatedMovies,
                                  movies: topRatedMovies!.moviesList,
                                  category: CategoryKeys.topRated,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }
}
