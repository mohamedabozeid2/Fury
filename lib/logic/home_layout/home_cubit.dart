import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/features/fury/data/models/single_movie_model.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
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

  void getAllMovies() {
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
              emit(FuryGetAllMoviesSuccessState());
            }).catchError((error) {
              debugPrint('Error in get top rated movies ${error.toString()}');
              emit(FuryGetTopRatedMoviesErrorState());
            });
          }).catchError((error) {
            debugPrint('Error in get trending movies ${error.toString()}');
            emit(FuryGetTrendingMoviesErrorState());
          });
        }).catchError((error) {
          debugPrint('Error in get popular movies ${error.toString()}');
          emit(FuryGetPopularMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
      }
    });
  }

  /////// Popular Movies //////

  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Response> getPopularMovies() {
    isFirstPopularLoadRunning = true;
    /////
    return DioHelper.getData(
        url: EndPoints.popular,
        query: {'api_key': DioHelper.apiKey, 'page': currentPopularPage});
  }

/////
//   bool hasNextPagePopular = true;
//   bool isLoadingMoreRunningPopular = false;
//   List<SingleMovieModel> morePopular = [];
//
//   bool hasNextPageTopRated = true;
//   bool isLoadingMoreRunningTopRated = false;
//   List<SingleMovieModel> moreTopRated = [];
//
//   bool hasNextPageTrending = true;
//   bool isLoadingMoreRunningTrending = false;
//   List<SingleMovieModel> moreTrending = [];
//
  //////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Response> getTopRatedMovies() {
    isFirstTopRatedLoadRunning = true;
    /////
    return DioHelper.getData(
        url: EndPoints.topRated,
        query: {'api_key': DioHelper.apiKey, 'page': currentTrendingPage});
  }

  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Response> getTrendingMovies() {
    isFirstTrendingLoadRunning = true;
    return DioHelper.getData(
        url: EndPoints.trending,
        query: {'api_key': DioHelper.apiKey, 'page': currentTrendingPage});
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
        }
        emit(FuryLoadMoreMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more movies ===> ${error.toString()}');
        emit(FuryLoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }
}
