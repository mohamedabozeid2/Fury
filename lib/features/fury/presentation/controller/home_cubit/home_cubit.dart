import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/HomeScreen.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/movies_model.dart';
import '../../../domain/entities/movie_keywards.dart';
import '../../../domain/entities/movies.dart';
import '../../../domain/entities/user_data.dart';
import '../../../domain/usecases/get_popular_movies_data.dart';
import '../../../domain/usecases/get_top_rated_movies_data.dart';
import '../../../domain/usecases/get_trending_movies_data.dart';
import '../../../domain/usecases/get_upcoming_movies_data.dart';
import '../../../../../core/keys/movies_category_keys.dart';
import '../../screens/my_movies_screen/my_movies_screen.dart';
import '../../screens/news_screen/news_screen.dart';
import '../../screens/settings/settings_screen.dart';
import 'home_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  final GetPopularMoviesDataUseCase getPopularMoviesDataUseCase;
  final GetTrendingMoviesDataUseCase getTrendingMoviesDataUseCase;
  final GetTopRatedMoviesDataUseCase getTopRatedMoviesDataUseCase;
  final GetUpcomingMoviesDataUseCase getUpcomingMoviesDataUseCase;

  MoviesCubit(
    this.getPopularMoviesDataUseCase,
    this.getTopRatedMoviesDataUseCase,
    this.getUpcomingMoviesDataUseCase,
    this.getTrendingMoviesDataUseCase,
  ) : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  void changBotNavBar({required int index}) {
    botNavCurrentIndex = index;
    emit(ChangeBotNavBarState());
  }

  List<Widget> screens = [
    const HomeScreen(),
    MyMoviesScreen(),
    const NewsScreen(),
    SettingsScreen(),
  ];

  List<GButton> bottomNavItems = [
    const GButton(icon: Icons.home, text: AppStrings.home),
    const GButton(icon: Icons.movie_filter_outlined, text: AppStrings.movies),
    const GButton(icon: Icons.newspaper, text: AppStrings.news),
    const GButton(icon: Icons.settings, text: AppStrings.settings),
  ];

  void getUserData({
    required String userID,
    bool fromHomeScreen = false,
  }) {
    if (!fromHomeScreen) {
      emit(GetUserDataLoadingState());
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      userModel = UserData.fromJson(value.data()!);
      if (!fromHomeScreen) {
        emit(GetUserDataSuccessState());
      }
    }).catchError((error) {
      debugPrint("Error ===> ${error.toString()}");
      emit(GetUserDataErrorState());
    });
  }

  void getAllMovies({required BuildContext context}) {
    emit(GetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        Future.wait([
          getPopularMovies(),
          getTrendingMovies(),
          getTopRatedMovies(),
          getUpComingMovies(),
        ]).then((value) {
          for (int i = 0; i < value.length; i++) {
            if (i == 0) {
              value[i].fold((l) {
                emit(GetPopularMoviesErrorState(message: l.message));
              }, (r) {
                popularMovies = r;
                isFirstPopularLoadRunning = false;
              });
            } else if (i == 1) {
              value[i].fold((l) {
                emit(GetTrendingMoviesErrorState(message: l.message));
              }, (r) {
                isFirstTrendingLoadRunning = false;
                trendingMovies = r;
              });
            } else if (i == 2) {
              value[i].fold((l) {
                emit(GetTopRatedMoviesErrorState(message: l.message));
              }, (r) {
                topRatedMovies = r;
                isFirstTopRatedLoadRunning = false;
              });
            } else if (i == 3) {
              value[i].fold((l) {
                emit(GetUpComingMoviesErrorState(message: l.message));
              }, (r) {
                upComingMovies = r;
                isFirstUpComingLoadRunning = false;
              });
            }
          }
          getMovieGenres();
          emit(GetAllMoviesSuccessState());
        }).catchError((error) {
          Components.navigateAndFinish(
              context: context, widget: NoInternetScreen());
          debugPrint('error ======================> ${error.toString()}');
          emit(GetAllMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
        Components.navigateAndFinish(
            context: context, widget: NoInternetScreen());
        Components.showSnackBar(
            title: AppStrings.appName,
            message: AppStrings.noInternet,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    });
  }

  /////////// Popular Movies ////////////
  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Either<Failure, Movies>> getPopularMovies() async {
    isFirstPopularLoadRunning = true;
    debugPrint('Done');
    return await getPopularMoviesDataUseCase.execute(
        currentPopularPage: currentPopularPage);
  }

  ///////////// Top Rated Movies ////////////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Either<Failure, Movies>> getTopRatedMovies() async {
    isFirstTopRatedLoadRunning = true;
    return await getTopRatedMoviesDataUseCase.execute(
        currentTopRatedPage: currentTopRatedPage);
  }

  ///////////// Trending Movies ////////////
  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Either<Failure, Movies>> getTrendingMovies() async {
    isFirstTrendingLoadRunning = true;
    return await getTrendingMoviesDataUseCase.execute(
        currentTrendingPage: currentTrendingPage);
  }

  ///////////// Up Coming Movies ////////////
  int currentUpComingPage = 1;
  bool isFirstUpComingLoadRunning = false;

  Future<Either<Failure, Movies>> getUpComingMovies() async {
    isFirstUpComingLoadRunning = true;
    return await getUpcomingMoviesDataUseCase.execute(
        currentUpComingPage: currentUpComingPage);
  }

//////////// Latest Movie ////////////
//   Future<Response> getLatestMovie() async{
//     return await MoviesDioHelper.getData(
//         url: EndPoints.latest,
//         query: {'api_key': MoviesDioHelper.apiKey, 'language': 'en-US'});
//   }

  void loadMoreMovies({
    required int page,
    required String moviesCategory,
    required bool hasMorePages,
    required bool isLoadingMore,
    int? movieID,
  }) {
    emit(LoadMoreMoviesLoadingState());
    bool hasNextPage = hasMorePages;
    bool isLoadingMoreRunning = isLoadingMore;
    late String endPoint;
    List<SingleMovie> more = [];

    if (hasNextPage && !isLoadingMoreRunning /*&& !isFirstLoadRunning*/) {
      isLoadingMoreRunning = true;
      more = [];
      if (moviesCategory == MoviesCategoryKeys.popular) {
        currentPopularPage++;
        endPoint = EndPoints.popular;
      } else if (moviesCategory == MoviesCategoryKeys.trending) {
        currentTrendingPage++;
        endPoint = EndPoints.trending;
      } else if (moviesCategory == MoviesCategoryKeys.topRated) {
        currentTopRatedPage++;
        endPoint = EndPoints.topRated;
      } else if (moviesCategory == MoviesCategoryKeys.upComing) {
        currentUpComingPage++;
        endPoint = EndPoints.upComing;
      } else if (moviesCategory == MoviesCategoryKeys.similarMovies) {
        currentSimilarMoviesPage++;
        endPoint = '/movie/$movieID/recommendations';
      }
      MoviesDioHelper.getData(
              url: endPoint,
              query: {'api_key': MoviesDioHelper.apiKey, 'page': page + 1})
          .then((value) {
        if (moviesCategory == MoviesCategoryKeys.popular) {
          morePopularMovies = MoviesModel.fromJson(value.data);
          if (morePopularMovies!.moviesList.isNotEmpty) {
            more.addAll(morePopularMovies!.moviesList);
            popularMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.trending) {
          moreTrendingMovies = MoviesModel.fromJson(value.data);
          if (moreTrendingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTrendingMovies!.moviesList);
            trendingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.topRated) {
          moreTopRatedMovies = MoviesModel.fromJson(value.data);
          if (moreTopRatedMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTopRatedMovies!.moviesList);
            topRatedMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.upComing) {
          moreUpComingMovies = MoviesModel.fromJson(value.data);
          if (moreUpComingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreUpComingMovies!.moviesList);
            upComingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.similarMovies) {
          moreSimilarMovies = MoviesModel.fromJson(value.data);
          if (moreSimilarMovies!.moviesList.isNotEmpty) {
            more.addAll(moreSimilarMovies!.moviesList);
            similarMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
            debugPrint('no more');
          }
        }
        emit(LoadMoreMoviesSuccessState());
      }).catchError((error) {
        debugPrint('Error from load more movies ===> ${error.toString()}');
        emit(LoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }

  MovieKeywords? keywords;

  Future<Response> getMovieKeyword({required SingleMovie movie}) async {
    return await MoviesDioHelper.getData(
        url: '/movie/${movie.id}/keywords',
        query: {'api_key': MoviesDioHelper.apiKey});
  }

  Genres? genresModel;

  void getMovieGenres() {
    MoviesDioHelper.getData(url: EndPoints.genres, query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
    }).then((value) {
      genresModel = Genres.fromJson(value.data);
    }).catchError((error) {
      debugPrint('Error in get genres ${error.toString()}');
      emit(GetMovieDetailsErrorState());
    });
  }

  List<String> genresList = [];

  Future<void> fillGenresList({required List<int> movieGenresId}) async {
    genresList = [];
    for (int i = 0; i < genresModel!.genres.length; i++) {
      if (movieGenresId.contains(genresModel!.genres[i].id)) {
        genresList.add(genresModel!.genres[i].name!);
      }
    }
  }

  int currentSimilarMoviesPage = 1;

  // MoviesModel? similarMovies;
  void getMovieDetailsData({required SingleMovie movie}) {
    Future.wait([
      getSimilarMovies(movie: movie),
      getMovieKeyword(movie: movie),
    ]).then((value) {
      for (int i = 0; i < value.length; i++) {
        if (i == 0) {
          currentSimilarMoviesPage = 1;
          similarMovies = MoviesModel.fromJson(value[i].data);
        } else if (i == 1) {
          debugPrint('KeyWords ${value[i].data}');
          keywords = MovieKeywords.fromJson(value[i].data);
        }
      }
      fillGenresList(movieGenresId: movie.genresIds).then((value) {
        emit(GetMovieDetailsSuccessState());
      });
    }).catchError((error) {
      debugPrint("Error in get movie details ${error.toString()}");
      emit(GetMovieDetailsErrorState());
    });
  }

  Future<Response> getSimilarMovies({required SingleMovie movie}) async {
    currentSimilarMoviesPage = 1;
    emit(GetMovieDetailsLoadingState());
    return await MoviesDioHelper.getData(
        url: '/movie/${movie.id}/recommendations',
        query: {
          'api_key': MoviesDioHelper.apiKey,
          'language': 'en-US',
          'page': currentSimilarMoviesPage,
        });
  }
}
