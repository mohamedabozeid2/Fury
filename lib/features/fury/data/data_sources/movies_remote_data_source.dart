import 'package:dio/dio.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/features/fury/data/models/movie_keywords_model.dart';
import 'package:movies_application/features/fury/data/models/request_token.dart';
import 'package:movies_application/features/fury/data/models/session_id_model.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';

import '../../../../core/network/movies_error_message_model.dart';
import '../../domain/entities/genres.dart';
import '../models/genres_model.dart';
import '../models/movies_model.dart';
import '../models/single_movie.dart';
import '../models/tv_keywords_model.dart';
import '../models/tv_model.dart';

abstract class BaseMoviesRemoteDataSource {
  Future<RequestTokenModel> requestToken();

  Future<RequestTokenModel> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  });

  Future<SessionIdModel> createNewSession({
    required String requestToken,
  });

  Future<MoviesModel> getPopularMoviesData({required int currentPopularPage});

  Future<MoviesModel> getUpComingMoviesData({required int currentUpComingPage});

  Future<MoviesModel> getTrendingMoviesData({required int currentTrendingPage});

  Future<MoviesModel> getTopRatedMoviesData({required int currentTopRatedPage});

  Future<MoviesModel> getNowPlayingMoviesData(
      {required int currentNowPlayingPage});

  Future<MovieKeywordsModel> getMovieKeyWords({required SingleMovie movie});

  Future<TVKeywordsModel> getTVShowKeywords({
    required SingleTV tvShow,
  });

  Future<MoviesModel> getSimilarMovies(
      {required SingleMovie movie, required int currentSimilarMoviesPage});

  Future<Genres> getGenres();

  Future<MoviesModel> searchMovies({
    required String searchContent,
    required int page,
    bool includeAdult = true,
  });

  Future<TvModel> getTvAiringToday({
    required int currentTvAiringTodayPage,
  });

  Future<TvModel> getPopularTv({
    required int currentPopularTvPage,
  });

  Future<TvModel> getTopRatedTv({
    required int currentTopRateTvPage,
  });

  Future<TvModel> getSimilarTvShows({
    required int currentTvAiringTodayPage,
    required SingleTV tvShow,
  });

  Future<TvModel> loadMoreTVShows({
    required int currentPage,
    required String endPoint,
  });

  Future<MoviesModel> loadMoreMovies({
    required int currentPage,
    required String endPoint,
  });
}

class MoviesRemoteDataSource extends BaseMoviesRemoteDataSource {
  @override
  Future<MoviesModel> getPopularMoviesData(
      {required int currentPopularPage}) async {
    final response = await MoviesDioHelper.getData(
        url: EndPoints.popularMovies,
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
        await MoviesDioHelper.getData(url: EndPoints.trendingMovies, query: {
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

  @override
  Future<MoviesModel> getNowPlayingMoviesData(
      {required int currentNowPlayingPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.nowPlaying, query: {
      'api_key': MoviesDioHelper.apiKey,
      'page': currentNowPlayingPage,
    });
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel: response.data,
      );
    }
  }

  @override
  Future<TvModel> getTvAiringToday(
      {required int currentTvAiringTodayPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.tvAiringToday, query: {
      "api_key": MoviesDioHelper.apiKey,
      "language": "en-US",
      "page": currentTvAiringTodayPage,
    });

    if (response.statusCode == 200) {
      return TvModel.fromJson(response.data);
    } else {
      throw MoviesServerException(moviesErrorMessageModel: response.data);
    }
  }

  @override
  Future<TvModel> getPopularTv({required int currentPopularTvPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.popularTv, query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
      'page': currentPopularTvPage,
    });
    if (response.statusCode == 200) {
      return TvModel.fromJson(response.data);
    } else {
      throw MoviesServerException(moviesErrorMessageModel: response.data);
    }
  }

  @override
  Future<TvModel> getSimilarTvShows(
      {required int currentTvAiringTodayPage, required SingleTV tvShow}) async {
    final response = await MoviesDioHelper.getData(
      url: '/tv/${tvShow.id}/recommendations',
      query: {
        "api_key": MoviesDioHelper.apiKey,
        "language": "en-US",
        "page": currentTvAiringTodayPage,
      },
    );
    if (response.statusCode == 200) {
      return TvModel.fromJson(response.data);
    } else {
      throw MoviesServerException(moviesErrorMessageModel: response.data);
    }
  }

  @override
  Future<TVKeywordsModel> getTVShowKeywords({required SingleTV tvShow}) async {
    final response =
        await MoviesDioHelper.getData(url: '/tv/${tvShow.id}/keywords', query: {
      "api_key": MoviesDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return TVKeywordsModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<TvModel> loadMoreTVShows(
      {required int currentPage, required String endPoint}) async {
    final response = await MoviesDioHelper.getData(url: endPoint, query: {
      "api_key": MoviesDioHelper.apiKey,
      "page": currentPage + 1,
    });
    if (response.statusCode == 200) {
      return TvModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesModel> loadMoreMovies(
      {required int currentPage, required String endPoint}) async {
    final response = await MoviesDioHelper.getData(url: endPoint, query: {
      "api_key": MoviesDioHelper.apiKey,
      "page": currentPage + 1,
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
  Future<TvModel> getTopRatedTv({required int currentTopRateTvPage}) async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.topRatedTv, query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
      'page': currentTopRateTvPage,
    });
    if (response.statusCode == 200) {
      return TvModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<RequestTokenModel> requestToken() async {
    final response =
        await MoviesDioHelper.getData(url: EndPoints.requestToken, query: {
      'api_key': MoviesDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<RequestTokenModel> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final Response response = await MoviesDioHelper.postData(
      url: EndPoints.createSessionWithLogin,
      data: {
        'username': userName,
        'password': password,
        'request_token': requestToken,
      },
      query: {
        'api_key': MoviesDioHelper.apiKey,
      },
    );
    if (response.statusCode == 200) {
      print("YES");
      return RequestTokenModel.fromJson(response.data);
    } else {
      print("NO");
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SessionIdModel> createNewSession(
      {required String requestToken}) async {
    final response = await MoviesDioHelper.postData(
      url: EndPoints.createSession,
      data: {
        'request_token': requestToken,
      },
      query: {
        'api_key': MoviesDioHelper.apiKey,
      },
    );
    if (response.statusCode == 200) {
      return SessionIdModel.fromJson(response.data);
    } else {
      throw MoviesServerException(
        moviesErrorMessageModel:
            MoviesErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
