import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/MovieItemBuilder.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/appbar_movie_builder.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../../../../core/utils/Colors.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/adaptive_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController popularMoviesScrollController = ScrollController();

  @override
  void initState() {
    MoviesCubit.get(context).getPopularMovies();
    MoviesCubit.get(context).getUserData(userID: uId, fromHomeScreen: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is FuryGetPopularMoviesLoadingState
              ? Center(
                  child: AdaptiveIndicator(
                  os: Components.getOS(),
                  color: AppColors.mainColor,
                ))
              : CustomScrollView(
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
                              height: Helper.getScreenHeight(context: context) *
                                  0.05,
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
                              child: Icon(Icons.search),
                            ),
                          )
                        ],
                      ),
                      // pinned: true,
                      expandedHeight:
                          Helper.getScreenHeight(context: context) * 0.7,
                      flexibleSpace: AppBarMovieBuilder(
                          image:
                              '${DioHelper.baseImageURL}${popularMovies!.moviesList[0].posterPath}'),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                Helper.getScreenHeight(context: context) * 0.01,
                            vertical: Helper.getScreenHeight(context: context) *
                                0.04),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Popular Movies',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Container(
                                    height: Helper.getScreenHeight(
                                            context: context) *
                                        0.2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: NotificationListener<
                                              ScrollEndNotification>(
                                            onNotification: (value) {
                                              if (popularMoviesScrollController
                                                  .position.atEdge) {
                                                if (popularMoviesScrollController
                                                        .position.pixels !=
                                                    0) {
                                                  print('true');
                                                  if (state
                                                      is FuryLoadMorePopularMoviesLoadingState) {
                                                    print('loading');
                                                  } else {
                                                    MoviesCubit.get(context)
                                                        .loadMorePopularMovies();
                                                  }
                                                }
                                                return true;
                                              } else {
                                                return false;
                                              }
                                            },
                                            child: ListView.separated(
                                                controller:
                                                    popularMoviesScrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return MovieItemBuilder(
                                                    movieModel: popularMovies!
                                                        .moviesList[index],
                                                    baseImageURL:
                                                        DioHelper.baseImageURL,
                                                    height:
                                                        Helper.getScreenHeight(
                                                                context:
                                                                    context) *
                                                            0.2,
                                                    width:
                                                        Helper.getScreenWidth(
                                                                context:
                                                                    context) *
                                                            0.3,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const SizedBox(
                                                    width: 7.0,
                                                  );
                                                },
                                                itemCount: popularMovies!
                                                    .moviesList.length),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
