import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/data/models/GenresModel.dart';
import 'package:movies_application/features/fury/data/models/single_movie_model.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/HomeScreen.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
import '../../features/fury/data/models/movie_keywards_model.dart';
import '../../features/fury/data/models/movies_model.dart';
import '../../features/fury/data/models/user_model.dart';
import '../../features/fury/presentation/screens/HomeScreen/widgets/category_item_builder/category_keys.dart';
import '../../features/fury/presentation/screens/my_movies_screen/my_movies_screen.dart';
import '../../features/fury/presentation/screens/settings/settings_screen.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  void changBotNavBar({required int index}) {
    botNavCurrentIndex = index;
    emit(ChangeBotNavBarState());
  }

  List<Widget> screens = [
    HomeScreen(),
    MyMoviesScreen(),
    SettingsScreen(),
  ];

  List<GButton> bottomNavItems = [
    GButton(icon: Icons.home, text: AppStrings.home),
    GButton(icon: Icons.movie_filter_outlined, text: AppStrings.movies),
    GButton(icon: Icons.settings, text: AppStrings.settings),
    // const BottomNavigationBarItem(
    //     icon: Icon(Icons.movie_filter_outlined), label: AppStrings.movies),
    // const BottomNavigationBarItem(
    //     icon: Icon(Icons.settings), label: AppStrings.settings),
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
      userModel = UserModel.fromJson(value.data()!);
      if (!fromHomeScreen) {
        emit(GetUserDataSuccessState());
      }
    }).catchError((error) {
      print("Error ===> ${error.toString()}");
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
              popularMovies = MoviesModel.fromJson(value[i].data);
              isFirstPopularLoadRunning = false;
            } else if (i == 1) {
              trendingMovies = MoviesModel.fromJson(value[i].data);
              isFirstTrendingLoadRunning = false;
            } else if (i == 2) {
              topRatedMovies = MoviesModel.fromJson(value[i].data);
              isFirstTopRatedLoadRunning = false;
            } else if (i == 3) {
              upComingMovies = MoviesModel.fromJson(value[i].data);
              isFirstUpComingLoadRunning = false;
              getMovieGenres();
            }
          }
          emit(GetAllMoviesSuccessState());
        }).catchError((error) {
          Components.navigateAndFinish(
              context: context, widget: NoInternetScreen());
          print('error ======================> ${error.toString()}');
          emit(GetTopRatedMoviesErrorState());
        });

        // getPopularMovies().then((value) {
        //   popularMovies = MoviesModel.fromJson(value.data);
        //   isFirstPopularLoadRunning = false;
        //
        //   // Trending Movies
        //   getTrendingMovies().then((value) {
        //     trendingMovies = MoviesModel.fromJson(value.data);
        //     isFirstTrendingLoadRunning = false;
        //
        //     // Top Rated Movies
        //     getTopRatedMovies().then((value) {
        //       topRatedMovies = MoviesModel.fromJson(value.data);
        //       isFirstTopRatedLoadRunning = false;
        //
        //       // Up Coming Movies
        //       getUpComingMovies().then((value) {
        //         upComingMovies = MoviesModel.fromJson(value.data);
        //         isFirstUpComingLoadRunning = false;
        //         getMovieGenres();
        //         emit(GetAllMoviesSuccessState());
        //       }).catchError((error) {
        //         Components.navigateAndFinish(
        //             context: context, widget: NoInternetScreen());
        //         debugPrint('Error in get upcoming movies ${error.toString()}');
        //       });
        //     }).catchError((error) {
        //       Components.navigateAndFinish(
        //           context: context, widget: NoInternetScreen());
        //       debugPrint('Error in get top rated movies ${error.toString()}');
        //       emit(GetTopRatedMoviesErrorState());
        //     });
        //   }).catchError((error) {
        //     Components.navigateAndFinish(
        //         context: context, widget: NoInternetScreen());
        //     debugPrint('Error in get trending movies ${error.toString()}');
        //     emit(GetTrendingMoviesErrorState());
        //   });
        // }).catchError((error) {
        //   Components.navigateAndFinish(
        //       context: context, widget: NoInternetScreen());
        //   debugPrint('Error in get popular movies ${error.toString()}');
        //   emit(GetPopularMoviesErrorState());
        // });
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

  ///////////// Popular Movies ////////////
  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Response> getPopularMovies() {
    isFirstPopularLoadRunning = true;
    return DioHelper.getData(
        url: EndPoints.popular,
        query: {'api_key': DioHelper.apiKey, 'page': currentPopularPage});
  }

  ///////////// Top Rated Movies ////////////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Response> getTopRatedMovies() {
    isFirstTopRatedLoadRunning = true;
    /////
    return DioHelper.getData(
        url: EndPoints.topRated,
        query: {'api_key': DioHelper.apiKey, 'page': currentTrendingPage});
  }

  ///////////// Trending Movies ////////////
  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Response> getTrendingMovies() {
    isFirstTrendingLoadRunning = true;
    return DioHelper.getData(
        url: EndPoints.trending,
        query: {'api_key': DioHelper.apiKey, 'page': currentTrendingPage});
  }

  ///////////// Up Coming Movies ////////////
  int currentUpComingPage = 1;
  bool isFirstUpComingLoadRunning = false;

  Future<Response> getUpComingMovies() {
    isFirstUpComingLoadRunning = true;
    return DioHelper.getData(
      url: EndPoints.upComing,
      lang: 'en-US',
      query: {
        'api_key': DioHelper.apiKey,
        'page': currentUpComingPage,
        'language': 'en-US'
      },
    );
  }

//////////// Latest Movie ////////////
  Future<Response> getLatestMovie() {
    return DioHelper.getData(
        url: EndPoints.latest,
        query: {'api_key': DioHelper.apiKey, 'language': 'en-US'});
  }

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
    List<SingleMovieModel> more = [];

    if (hasNextPage && !isLoadingMoreRunning /*&& !isFirstLoadRunning*/) {
      isLoadingMoreRunning = true;
      more = [];
      if (moviesCategory == CategoryKeys.popular) {
        currentPopularPage++;
        endPoint = EndPoints.popular;
      } else if (moviesCategory == CategoryKeys.trending) {
        currentTrendingPage++;
        endPoint = EndPoints.trending;
      } else if (moviesCategory == CategoryKeys.topRated) {
        currentTopRatedPage++;
        endPoint = EndPoints.topRated;
      } else if (moviesCategory == CategoryKeys.upComing) {
        currentUpComingPage++;
        endPoint = EndPoints.upComing;
      } else if (moviesCategory == CategoryKeys.similarMovies) {
        currentSimilarMoviesPage++;
        endPoint = '/movie/$movieID/recommendations';
      }
      DioHelper.getData(
          url: endPoint,
          query: {'api_key': DioHelper.apiKey, 'page': page + 1}).then((value) {
        if (moviesCategory == CategoryKeys.popular) {
          morePopularMovies = MoviesModel.fromJson(value.data);
          if (morePopularMovies!.moviesList.isNotEmpty) {
            more.addAll(morePopularMovies!.moviesList);
            popularMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.trending) {
          moreTrendingMovies = MoviesModel.fromJson(value.data);
          if (moreTrendingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTrendingMovies!.moviesList);
            trendingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.topRated) {
          moreTopRatedMovies = MoviesModel.fromJson(value.data);
          if (moreTopRatedMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTopRatedMovies!.moviesList);
            topRatedMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.upComing) {
          moreUpComingMovies = MoviesModel.fromJson(value.data);
          if (moreUpComingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreUpComingMovies!.moviesList);
            upComingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.similarMovies) {
          moreSimilarMovies = MoviesModel.fromJson(value.data);
          if (moreSimilarMovies!.moviesList.isNotEmpty) {
            more.addAll(moreSimilarMovies!.moviesList);
            similarMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
            print('no more');
          }
        }
        emit(LoadMoreMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more movies ===> ${error.toString()}');
        emit(LoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }

  MovieKeywordsModel? keywords;

  Future<void> getMovieKeyword({required SingleMovieModel movie}) async {
    await DioHelper.getData(
        url: '/movie/${movie.id}/keywords',
        query: {'api_key': DioHelper.apiKey}).then((value) {
      keywords = MovieKeywordsModel.fromJson(value.data);
    }).catchError((error) {
      emit(GetMovieDetailsErrorState());
    });
  }

  GenresModel? genresModel;

  void getMovieGenres() {
    // emit(GetMovieGenresLoadingState());
    DioHelper.getData(url: EndPoints.genres, query: {
      'api_key': DioHelper.apiKey,
      'language': 'en-US',
    }).then((value) {
      genresModel = GenresModel.fromJson(value.data);
      // emit(GetMovieGenresSuccessState());
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

  Future<void> getSimilarMovies({required SingleMovieModel movie}) async {
    currentSimilarMoviesPage = 1;
    emit(GetMovieDetailsLoadingState());
    await DioHelper.getData(url: '/movie/${movie.id}/recommendations', query: {
      'api_key': DioHelper.apiKey,
      'language': 'en-US',
      'page': currentSimilarMoviesPage,
    }).then((value) {
      currentSimilarMoviesPage = 1;
      similarMovies = MoviesModel.fromJson(value.data);
      getMovieKeyword(movie: movie).then((value) {
        fillGenresList(movieGenresId: movie.genresIds).then((value) {
          print('from get similar ${similarMovies!.moviesList.length}');
          emit(GetMovieDetailsSuccessState());
        });
      });
    }).catchError((error) {
      debugPrint('Error in Get Similar Movies ${error.toString()}');
      emit(GetMovieDetailsErrorState());
    });
  }
}
