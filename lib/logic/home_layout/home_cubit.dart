import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/data/models/single_movie_model.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
import '../../features/fury/data/models/movie_keywards_model.dart';
import '../../features/fury/data/models/movies_model.dart';
import '../../features/fury/data/models/user_model.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  void getUserData({
    required String userID,
    bool fromHomeScreen = false,
  }) {
    if (!fromHomeScreen) {
      emit(FuryGetUserDataLoadingState());
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      userModel = FuryUserModel.fromJson(value.data()!);
      if (!fromHomeScreen) {
        emit(FuryGetUserDataSuccessState());
      }
      print('done');
    }).catchError((error) {
      print("Error ===> ${error.toString()}");
      emit(FuryGetUserDataErrorState());
    });
  }

  void getAllMovies ({required BuildContext context}) {
    emit(FuryGetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        // Popular Movies

        getPopularMovies().then((value) {
          popularMovies = MoviesModel.fromJson(value.data);
          isFirstPopularLoadRunning = false;

          // Trending Movies
          getTrendingMovies().then((value) {
            trendingMovies = MoviesModel.fromJson(value.data);
            isFirstTrendingLoadRunning = false;

            // Top Rated Movies
            getTopRatedMovies().then((value) {
              topRatedMovies = MoviesModel.fromJson(value.data);
              isFirstTopRatedLoadRunning = false;

              // Up Coming Movies
              getUpComingMovies().then((value) {
                upComingMovies = MoviesModel.fromJson(value.data);
                isFirstUpComingLoadRunning = false;
                // throw Exception('Error');
                emit(FuryGetAllMoviesSuccessState());
              }).catchError((error) {
                Components.navigateAndFinish(context: context, widget: NoInternetScreen());
                debugPrint('Error in get upcoming movies ${error.toString()}');
              });
            }).catchError((error) {
              Components.navigateAndFinish(context: context, widget: NoInternetScreen());
              debugPrint('Error in get top rated movies ${error.toString()}');
              emit(FuryGetTopRatedMoviesErrorState());
            });
          }).catchError((error) {
            Components.navigateAndFinish(context: context, widget: NoInternetScreen());
            debugPrint('Error in get trending movies ${error.toString()}');
            emit(FuryGetTrendingMoviesErrorState());
          });
        }).catchError((error) {
          Components.navigateAndFinish(context: context, widget: NoInternetScreen());
          debugPrint('Error in get popular movies ${error.toString()}');
          emit(FuryGetPopularMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
        Components.navigateAndFinish(context: context, widget: NoInternetScreen());
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
        query: {'api_key': DioHelper.apiKey, 'page': currentUpComingPage});
  }

//////////// Latest Movie ////////////
  Future<Response> getLatestMovie() {
    return DioHelper.getData(
        url: EndPoints.latest,
        query: {'api_key': DioHelper.apiKey, 'language': 'en-US'});
  }

  void loadMoreMovies(
      {required int page,
      required String moviesCategory,
      required bool hasMorePages,
      required bool isLoadingMore}) {
    emit(FuryLoadMoreMoviesLoadingState());
    bool hasNextPage = hasMorePages;
    bool isLoadingMoreRunning = isLoadingMore;
    late String endPoint;
    List<SingleMovieModel> more = [];

    if (hasNextPage && !isLoadingMoreRunning /*&& !isFirstLoadRunning*/) {
      isLoadingMoreRunning = true;
      more = [];
      if (moviesCategory == 'popular') {
        currentPopularPage++;
        endPoint = EndPoints.popular;
      } else if (moviesCategory == 'trending') {
        currentTrendingPage++;
        endPoint = EndPoints.trending;
      } else if (moviesCategory == 'topRated') {
        currentTopRatedPage++;
        endPoint = EndPoints.topRated;
      } else if (moviesCategory == 'upComing') {
        currentUpComingPage++;
        endPoint = EndPoints.upComing;
      }

      DioHelper.getData(
          url: endPoint,
          query: {'api_key': DioHelper.apiKey, 'page': page + 1}).then((value) {
        if (moviesCategory == 'popular') {
          morePopularMovies = MoviesModel.fromJson(value.data);
          if (morePopularMovies!.moviesList.isNotEmpty) {
            more.addAll(morePopularMovies!.moviesList);
            popularMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == 'trending') {
          moreTrendingMovies = MoviesModel.fromJson(value.data);
          if (moreTrendingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTrendingMovies!.moviesList);
            trendingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == 'topRated') {
          moreTopRatedMovies = MoviesModel.fromJson(value.data);
          if (moreTopRatedMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTopRatedMovies!.moviesList);
            topRatedMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == 'upComing') {
          moreUpComingMovies = MoviesModel.fromJson(value.data);
          if (moreUpComingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreUpComingMovies!.moviesList);
            upComingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        }
        emit(FuryLoadMoreMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more movies ===> ${error.toString()}');
        emit(FuryLoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }


  MovieKeywordsModel? keywords;
  void getMovieKeyword({required int movieId}){
    emit(FuryGetMovieKeywordLoadingState());
    DioHelper.getData(url: '/movie/$movieId/keywords',query: {
      'api_key' : DioHelper.apiKey
    }).then((value){
      keywords = MovieKeywordsModel.fromJson(value.data);
      emit(FuryGetMovieKeywordSuccessState());
    }).catchError((error){
      emit(FuryGetMovieKeywordErrorState());
    });
  }
}
