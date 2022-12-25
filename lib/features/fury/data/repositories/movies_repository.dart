import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/domain/entities/movie_keywords.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/entities/request_token.dart';
import 'package:movies_application/features/fury/domain/entities/session_id.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../domain/entities/tv_keywords.dart';
import '../data_sources/movies_remote_data_source.dart';
import '../models/single_movie.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource baseMoviesRemoteDataSource;

  MoviesRepository(this.baseMoviesRemoteDataSource);

  @override
  Future<Either<Failure, RequestToken>> getRequestToken() async {
    final result = await baseMoviesRemoteDataSource.requestToken();
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Movies>> getPopularMoviesData(
      {required int currentPopularPage}) async {
    final result = await baseMoviesRemoteDataSource.getPopularMoviesData(
        currentPopularPage: currentPopularPage);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Movies>> getTopRatedMoviesData(
      {required int currentTopRatedPage}) async {
    final result = await baseMoviesRemoteDataSource.getTopRatedMoviesData(
        currentTopRatedPage: currentTopRatedPage);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Movies>> getTrendingMoviesData(
      {required int currentTrendingPage}) async {
    final result = await baseMoviesRemoteDataSource.getTrendingMoviesData(
        currentTrendingPage: currentTrendingPage);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Movies>> getUpcomingMoviesData(
      {required int currentUpComingPage}) async {
    final result = await baseMoviesRemoteDataSource.getUpComingMoviesData(
        currentUpComingPage: currentUpComingPage);

    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, MovieKeywords>> getMovieKeywords(
      {required SingleMovie movie}) async {
    final result =
        await baseMoviesRemoteDataSource.getMovieKeyWords(movie: movie);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movies>> getSimilarMovie(
      {required SingleMovie movie,
      required int currentSimilarMoviesPage}) async {
    final result = await baseMoviesRemoteDataSource.getSimilarMovies(
      movie: movie,
      currentSimilarMoviesPage: currentSimilarMoviesPage,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Genres>> getGenres() async {
    final result = await baseMoviesRemoteDataSource.getGenres();
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movies>> searchMovie({
    required int page,
    required String searchContent,
  }) async {
    final result = await baseMoviesRemoteDataSource.searchMovies(
        searchContent: searchContent, page: page);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movies>> getNowPlayingMoviesData(
      {required int currentNowPlayingPage}) async {
    final result = await baseMoviesRemoteDataSource.getNowPlayingMoviesData(
      currentNowPlayingPage: currentNowPlayingPage,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Tv>> getAiringToday(
      {required int currentTvAiringTodayPage}) async {
    final result = await baseMoviesRemoteDataSource.getTvAiringToday(
        currentTvAiringTodayPage: currentTvAiringTodayPage);
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Tv>> getSimilarTVShows(
      {required SingleTV tvShow, required int currentSimilarTvPage}) async {
    final result = await baseMoviesRemoteDataSource.getSimilarTvShows(
      currentTvAiringTodayPage: currentSimilarTvPage,
      tvShow: tvShow,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, TVKeywords>> getTVKeywords(
      {required SingleTV tvShow}) async {
    final result = await baseMoviesRemoteDataSource.getTVShowKeywords(
      tvShow: tvShow,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Tv>> loadMoreTVShows({
    required int currentPage,
    required String endPoint,
  }) async {
    final result = await baseMoviesRemoteDataSource.loadMoreTVShows(
      currentPage: currentPage,
      endPoint: endPoint,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Movies>> loadMoreMovies(
      {required int currentPage, required String endPoint}) async {
    final result = await baseMoviesRemoteDataSource.loadMoreMovies(
      currentPage: currentPage,
      endPoint: endPoint,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(
        failure.moviesErrorMessageModel.statusMessage,
      ));
    }
  }

  @override
  Future<Either<Failure, Tv>> getPopularTv(
      {required int currentPopularTvPage}) async {
    final result = await baseMoviesRemoteDataSource.getPopularTv(
      currentPopularTvPage: currentPopularTvPage,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Tv>> getTopRatedTv(
      {required int currentTopRateTvPage}) async {
    final result = await baseMoviesRemoteDataSource.getTopRatedTv(
      currentTopRateTvPage: currentTopRateTvPage,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, RequestToken>> createSessionWithLogin(
      {required String userName,
      required String password,
      required String requestToken}) async {
    final result = await baseMoviesRemoteDataSource.createSessionWithLogin(
      userName: userName,
      password: password,
      requestToken: requestToken,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SessionId>> createNewSession(
      {required String requestToken}) async {
    final result = await baseMoviesRemoteDataSource.createNewSession(
      requestToken: requestToken,
    );
    try {
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }
}
