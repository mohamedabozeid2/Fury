
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_application/core/keys/movies_category_keys.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_screen/widgets/appbar_movie_builder.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_screen/widgets/category_item_builder/category_item_builder.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_screen/widgets/search_icon_button.dart';

import '../../../../../core/api/movies_dio_helper.dart';
import '../../../../../core/keys/tv_category_keys.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../core/widgets/drawer_icon_button.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  int randomPosterNumber = 0;
  @override
  void initState() {
    super.initState();
    randomPosterNumber = Random().nextInt(10);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerIconButton(),
              SearchIconButton(),
            ],
          ),
          // pinned: true,
          expandedHeight: Helper.maxHeight * 0.7,
          flexibleSpace: AppBarMovieBuilder(
            movieOrTv: trendingMovies!.moviesList[randomPosterNumber],
            image:
            '${MoviesDioHelper.baseImageURL}${trendingMovies!.moviesList[randomPosterNumber].posterPath}',
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Helper.maxHeight * 0.01,
                vertical: Helper.maxHeight * 0.04),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryItemBuilder(
                        title: AppStrings.upComingMovies,
                        isMovie: true,
                        movies: upComingMovies!.moviesList,
                        category: MoviesCategoryKeys.upComing,
                      ),
                      CategoryItemBuilder(
                        isMovie: true,
                        title: AppStrings.trendingMovies,
                        movies: trendingMovies!.moviesList,
                        category: MoviesCategoryKeys.trending,
                      ),
                      CategoryItemBuilder(
                        isMovie: true,
                        title: AppStrings.topRatedMovies,
                        movies: topRatedMovies!.moviesList,
                        category: MoviesCategoryKeys.topRated,
                      ),
                      CategoryItemBuilder(
                        isMovie: true,
                        title: AppStrings.popularMovies,
                        movies: popularMovies!.moviesList,
                        category: MoviesCategoryKeys.popular,
                      ),
                      CategoryItemBuilder(
                        isMovie: true,
                        title: AppStrings.nowPlayingMovies,
                        movies: nowPlayingMovies!.moviesList,
                        category: MoviesCategoryKeys.nowPlaying,
                      ),
                      CategoryItemBuilder(
                        isMovie: false,
                        title: AppStrings.topRatedTv,
                        category: TVCategoryKeys.topRatedTv,
                        tv: topRatedTv!.tvList,
                      ),
                      CategoryItemBuilder(
                        isMovie: false,
                        title: AppStrings.popularTv,
                        category: TVCategoryKeys.popularTv,
                        tv: popularTv!.tvList,
                      ),
                      CategoryItemBuilder(
                        isMovie: false,
                        title: AppStrings.tvAiringToday,
                        category: TVCategoryKeys.tvAiringToday,
                        tv: tvAiringToday!.tvList,
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
  }
}
