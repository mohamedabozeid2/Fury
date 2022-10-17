import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/features/fury/data/models/movie_model.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
import '../../features/fury/data/models/popular_movies_model.dart';
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

  int currentPopularPage = 1;
  int currentTrendingPage = 1;
  bool isFirstPopularLoadRunning = false;
  bool isFirstTrendingLoadRunning = false;

  void getAllMovies() {
    emit(FuryGetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        // Popular Movies

        getPopularMovies().then((value) {
          popularMovies = MoviesModel.fromJson(value.data);
          isFirstPopularLoadRunning = false;

          // Trending movies
          getTrendingMovies().then((value) {
            trendingMovies = MoviesModel.fromJson(value.data);
            isFirstTrendingLoadRunning = false;
            emit(FuryGetAllMoviesSuccessState());
          }).catchError((error) {
            debugPrint('Error in get trending movies');
            emit(FuryGetTrendingMoviesErrorState());
          });
        }).catchError((error) {
          debugPrint('Error in get popular movies');
          emit(FuryGetPopularMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
      }
    });
  }

  Future<Response> getPopularMovies() {
    // emit(FuryGetPopularMoviesLoadingState());
    isFirstPopularLoadRunning = true;
    /////
    return DioHelper.getData(url: EndPoints.popular, query: {
      'api_key': DioHelper.apiKey,
      'page': currentPopularPage
    }); /*.then((value) {
      popularMovies = MoviesModel.fromJson(value.data);
      isFirstPopularLoadRunning = false;
      emit(FuryGetPopularMoviesSuccessState());
    }).catchError((error) {
      print('Error in get data ===> ${error.toString()}');
      emit(FuryGetPopularMoviesErrorState());
    });*/
    /////
    // CheckConnection.checkConnection().then((value) {
    //   internetConnection = value;
    //   if (value == true) {
    //     DioHelper.getData(url: EndPoints.popular, query: {
    //       'api_key': DioHelper.apiKey,
    //       'page': currentPopularPage
    //     }).then((value) {
    //       popularMovies = MoviesModel.fromJson(value.data);
    //       isFirstPopularLoadRunning = false;
    //       emit(FuryGetPopularMoviesSuccessState());
    //     }).catchError((error) {
    //       print('Error in get data ===> ${error.toString()}');
    //       emit(FuryGetPopularMoviesErrorState());
    //     });
    //   }
    // });
  }

  Future<Response> getTrendingMovies() {
    // emit(FuryGetTrendingMoviesLoadingState());
    isFirstTrendingLoadRunning = true;
    return DioHelper.getData(
        url: EndPoints.trending,
        query: {'api_key': DioHelper.apiKey, 'page': currentTrendingPage});
    // CheckConnection.checkConnection().then((value) {
    //   internetConnection = value;
    //   if (value == true) {
    //     DioHelper.getData(url: EndPoints.trending, query: {
    //       'api_key': DioHelper.apiKey,
    //       'page': currentTrendingPage
    //     }).then((value) {
    //       trendingMovies = MoviesModel.fromJson(value.data);
    //       isFirstTrendingLoadRunning = false;
    //       emit(FuryGetTrendingMoviesSuccessState());
    //     }).catchError((error) {
    //       print('Error in get trending data ===> ${error.toString()}');
    //       emit(FuryGetTrendingMoviesErrorState());
    //     });
    //   }else{
    //     print('no internet');
    //   }
    // });
  }

  bool hasNextPagePopular = true;
  bool isLoadingMoreRunningPopular = false;
  List<MovieModel> morePopular = [];

  void loadMorePopularMovies() {
    emit(FuryLoadMorePopularMoviesLoadingState());
    if (hasNextPagePopular &&
        !isLoadingMoreRunningPopular &&
        !isFirstPopularLoadRunning) {
      isLoadingMoreRunningPopular = true;
      morePopular = [];
      currentPopularPage++;
      DioHelper.getData(
              url: EndPoints.popular,
              query: {'api_key': DioHelper.apiKey, 'page': currentPopularPage})
          .then((value) {
        morePopularMovies = MoviesModel.fromJson(value.data);
        if (morePopularMovies!.moviesList.isNotEmpty) {
          morePopular.addAll(morePopularMovies!.moviesList);
          popularMovies!.loadMoreMovies(movies: morePopular);
          // popularMovies.addAll(morePopularMovies);
        } else {
          hasNextPagePopular = false;
        }
        emit(FuryLoadMorePopularMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more popular movies ===> ${error.toString()}');
        emit(FuryLoadMorePopularMoviesErrorState());
      });
      isLoadingMoreRunningPopular = false;
    }
  }

  bool hasNextPageTrending = true;
  bool isLoadingMoreRunningTrending = false;
  List<MovieModel> moreTrending = [];

  void loadMoreTrendingMovies() {
    emit(FuryLoadMoreTrendingMoviesLoadingState());
    if (hasNextPageTrending &&
        !isLoadingMoreRunningTrending &&
        !isFirstPopularLoadRunning) {
      isLoadingMoreRunningTrending = true;
      moreTrending = [];
      currentPopularPage++;
      DioHelper.getData(
              url: EndPoints.popular,
              query: {'api_key': DioHelper.apiKey, 'page': currentPopularPage})
          .then((value) {
        moreTrendingMovies = MoviesModel.fromJson(value.data);
        if (moreTrendingMovies!.moviesList.isNotEmpty) {
          moreTrending.addAll(moreTrendingMovies!.moviesList);
          trendingMovies!.loadMoreMovies(movies: moreTrending);
        } else {
          hasNextPageTrending = false;
        }
        emit(FuryLoadMoreTrendingMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more popular movies ===> ${error.toString()}');
        emit(FuryLoadMoreTrendingMoviesErrorState());
      });
      isLoadingMoreRunningTrending = false;
    }
  }
}
