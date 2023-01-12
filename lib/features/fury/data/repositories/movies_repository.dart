import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/account_details.dart';
import 'package:movies_application/features/fury/domain/entities/favorite_data.dart';
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
    try {
      final result = await baseMoviesRemoteDataSource.requestToken();
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
    try {
      final result = await baseMoviesRemoteDataSource.getPopularMoviesData(
          currentPopularPage: currentPopularPage);
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
    try {
      final result = await baseMoviesRemoteDataSource.getTopRatedMoviesData(
          currentTopRatedPage: currentTopRatedPage);
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
    try {
      final result = await baseMoviesRemoteDataSource.getTrendingMoviesData(
          currentTrendingPage: currentTrendingPage);
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
    try {
      final result = await baseMoviesRemoteDataSource.getUpComingMoviesData(
          currentUpComingPage: currentUpComingPage);
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
    try {
      final result =
          await baseMoviesRemoteDataSource.getMovieKeyWords(movie: movie);
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movies>> getSimilarMovie(
      {required SingleMovie movie,
      required int currentSimilarMoviesPage}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getSimilarMovies(
        movie: movie,
        currentSimilarMoviesPage: currentSimilarMoviesPage,
      );
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(failure.moviesErrorMessageModel.statusMessage),
      );
    }
  }

  @override
  Future<Either<Failure, Genres>> getGenres() async {
    try {
      final result = await baseMoviesRemoteDataSource.getGenres();
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
    try {
      final result = await baseMoviesRemoteDataSource.searchMovies(
          searchContent: searchContent, page: page);
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movies>> getNowPlayingMoviesData(
      {required int currentNowPlayingPage}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getNowPlayingMoviesData(
        currentNowPlayingPage: currentNowPlayingPage,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.getTvAiringToday(
          currentTvAiringTodayPage: currentTvAiringTodayPage);
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(ServerFailure(failure.moviesErrorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Tv>> getSimilarTVShows(
      {required SingleTV tvShow, required int currentSimilarTvPage}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getSimilarTvShows(
        currentTvAiringTodayPage: currentSimilarTvPage,
        tvShow: tvShow,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.getTVShowKeywords(
        tvShow: tvShow,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.loadMoreTVShows(
        currentPage: currentPage,
        endPoint: endPoint,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.loadMoreMovies(
        currentPage: currentPage,
        endPoint: endPoint,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.getPopularTv(
        currentPopularTvPage: currentPopularTvPage,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.getTopRatedTv(
        currentTopRateTvPage: currentTopRateTvPage,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.createSessionWithLogin(
        userName: userName,
        password: password,
        requestToken: requestToken,
      );
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
    try {
      final result = await baseMoviesRemoteDataSource.createNewSession(
        requestToken: requestToken,
      );
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
  Future<Either<Failure, AccountDetails>> getAccountDetails(
      {required String sessionId}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getAccountDetails(
          sessionId: sessionId);
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
  Future<Either<Failure, FavoriteData>> addToWatchList(
      {required String accountId,
      required String sessionId,
      required String mediaType,
      required int mediaId,
      required bool watchList}) async {
    try {
      final result = await baseMoviesRemoteDataSource.addToWatchList(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: mediaType,
        mediaId: mediaId,
        watchList: watchList,
      );
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }

  // @override
  // Future<Either<Failure, Movies>> getFavoriteMovies(
  //     {required String accountId,
  //     required String sessionId,
  //     required int currentFavoriteMoviesPage}) async {
  //   try {
  //     final result = await baseMoviesRemoteDataSource.getFavoriteMovies(
  //       accountId: accountId,
  //       sessionId: sessionId,
  //       currentFavoriteMoviesPage: currentFavoriteMoviesPage,
  //     );
  //     return Right(result);
  //   } on MoviesServerException catch (failure) {
  //     return Left(
  //       ServerFailure(
  //         failure.moviesErrorMessageModel.statusMessage,
  //       ),
  //     );
  //   }
  // }

  // @override
  // Future<Either<Failure, Tv>> getFavoriteTvShows(
  //     {required String accountId,
  //     required String sessionId,
  //     required int currentFavoriteTvShowsPage}) async {
  //   try {
  //     final result = await baseMoviesRemoteDataSource.getFavoriteTvShows(
  //       accountId: accountId,
  //       sessionId: sessionId,
  //       currentFavoriteTvShowsPage: currentFavoriteTvShowsPage,
  //     );
  //     return Right(result);
  //   } on MoviesServerException catch (failure) {
  //     return Left(
  //       ServerFailure(
  //         failure.moviesErrorMessageModel.statusMessage,
  //       ),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, Movies>> getMoviesWatchList(
      {required String accountId,
      required String sessionId,
      required int currentMoviesWatchListPage}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getMoviesWatchList(
        accountId: accountId,
        sessionId: sessionId,
        currentMoviesWatchListPage: currentMoviesWatchListPage,
      );
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
  Future<Either<Failure, Tv>> getTvShowsWatchList(
      {required String accountId,
      required String sessionId,
      required int currentTvShowsWatchListPage}) async {
    try {
      final result = await baseMoviesRemoteDataSource.getTvShowsWatchList(
        accountId: accountId,
        sessionId: sessionId,
        currentTvShowsWatchListPage: currentTvShowsWatchListPage,
      );
      return Right(result);
    } on MoviesServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessageModel.statusMessage,
        ),
      );
    }
  }

  // @override
  // Future<Either<Failure, FavoriteData>> markAsFavorite(
  //     {required String accountId,
  //     required String sessionId,
  //     required String mediaType,
  //     required int mediaId,
  //     required bool favorite}) async {
  //   try {
  //     final result = await baseMoviesRemoteDataSource.markAsFavorite(
  //       accountId: accountId,
  //       sessionId: sessionId,
  //       mediaType: mediaType,
  //       mediaId: mediaId,
  //       favorite: favorite,
  //     );
  //     return Right(result);
  //   } on MoviesServerException catch (failure) {
  //     return Left(
  //       ServerFailure(
  //         failure.moviesErrorMessageModel.statusMessage,
  //       ),
  //     );
  //   }
  // }
}
