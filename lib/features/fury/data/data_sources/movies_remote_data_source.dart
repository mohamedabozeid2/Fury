import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/features/fury/data/models/movie_keywords_model.dart';

import '../../../../core/network/movies_error_message_model.dart';
import '../../domain/entities/genres.dart';
import '../models/genres_model.dart';
import '../models/movies_model.dart';
import '../models/single_movie.dart';

abstract class BaseMoviesRemoteDataSource {
  Future<MoviesModel> getPopularMoviesData({required int currentPopularPage});

  Future<MoviesModel> getUpComingMoviesData({required int currentUpComingPage});

  Future<MoviesModel> getTrendingMoviesData({required int currentTrendingPage});

  Future<MoviesModel> getTopRatedMoviesData({required int currentTopRatedPage});

  Future<MovieKeywordsModel> getMovieKeyWords({required SingleMovie movie});

  Future<MoviesModel> getSimilarMovies(
      {required SingleMovie movie, required int currentSimilarMoviesPage});

  Future<Genres> getGenres();

  Future<MoviesModel> searchMovies({
    required String searchContent,
    required int page,
    bool includeAdult = true,
  });
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

  @override
  Future<MovieKeywordsModel> getMovieKeyWords(
      {required SingleMovie movie}) async {
    final response = await MoviesDioHelper.getData(
        url: '/movie/${movie.id}/keywords',
        query: {
          'api_key': MoviesDioHelper.apiKey,
        });
    if (response.statusCode == 200) {
      return MovieKeywordsModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> getSimilarMovies(
      {required SingleMovie movie,
      required int currentSimilarMoviesPage}) async {
    final response = await MoviesDioHelper.getData(
        url: "/movie/${movie.id}/recommendations",
        query: {
          'api_key': MoviesDioHelper.apiKey,
          'language': 'en-US',
          'page': currentSimilarMoviesPage,
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
  Future<Genres> getGenres() async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.genres, query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
    });
    if (response.statusCode == 200) {
      return GenresModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> searchMovies({
    required String searchContent,
    required int page,
    bool includeAdult = true,
  }) async {
    final response = await MoviesDioHelper.getData(
      url: EndPoints.searchMovies,
      query: {
        "language": "en-US",
        "api_key": MoviesDioHelper.apiKey,
        "query": searchContent,
        "page": "$page",
        "include_adult": "$includeAdult",
      },
    );
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
