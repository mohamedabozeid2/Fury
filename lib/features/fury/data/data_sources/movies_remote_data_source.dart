import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/network/news_error_message_model.dart';

import '../../../../core/network/movies_error_message_model.dart';
import '../models/movies_model.dart';

abstract class BaseMoviesRemoteDataSource {
  Future<MoviesModel> getPopularMoviesData({required int currentPopularPage});

  Future<MoviesModel> getUpComingMoviesData({required int currentUpComingPage});

  Future<MoviesModel> getTrendingMoviesData({required int currentTrendingPage});

  Future<MoviesModel> getTopRatedMoviesData({required int currentTopRatedPage});
}

class MoviesRemoteDataSource extends BaseMoviesRemoteDataSource {
  @override
  Future<MoviesModel> getPopularMoviesData(
      {required int currentPopularPage}) async {
    final response = await MoviesDioHelper.getData(
        url: EndPoints.popular,
        query: {'api_key': MoviesDioHelper.apiKey, 'page': currentPopularPage});
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> getTopRatedMoviesData(
      {required int currentTopRatedPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.topRated, query: {
      'api_key': MoviesDioHelper.apiKey,
      'page': currentTopRatedPage,
    });
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> getTrendingMoviesData(
      {required int currentTrendingPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.trending, query: {
      'api_key': MoviesDioHelper.apiKey,
      'page': currentTrendingPage,
    });
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> getUpComingMoviesData(
      {required int currentUpComingPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.upComing, query: {
      'api_key': MoviesDioHelper.apiKey,
      'page': currentUpComingPage,
    });
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
