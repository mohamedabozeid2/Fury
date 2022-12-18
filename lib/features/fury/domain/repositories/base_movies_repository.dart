import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/domain/entities/movie_keywards.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';

import '../../data/models/single_movie.dart';
import '../entities/movies.dart';
import '../entities/tv_keywords.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, Movies>> getPopularMoviesData({
    required int currentPopularPage,
  });

  Future<Either<Failure, Movies>> getUpcomingMoviesData({
    required int currentUpComingPage,
  });

  Future<Either<Failure, Movies>> getTrendingMoviesData({
    required int currentTrendingPage,
  });

  Future<Either<Failure, Movies>> getTopRatedMoviesData({
    required int currentTopRatedPage,
  });

  Future<Either<Failure, Movies>> getNowPlayingMoviesData({
    required int currentNowPlayingPage,
  });

  Future<Either<Failure, MovieKeywords>> getMovieKeywords({
    required SingleMovie movie,
  });

  Future<Either<Failure, Movies>> getSimilarMovie({
    required SingleMovie movie,
    required int currentSimilarMoviesPage,
  });

  Future<Either<Failure, Movies>> searchMovie({
    required int page,
    required String searchContent,
  });

  Future<Either<Failure, Genres>> getGenres();

  Future<Either<Failure, Tv>> getAiringToday(
      {required int currentTvAiringTodayPage});

  Future<Either<Failure, Tv>> getSimilarTVShows({
    required SingleTV tvShow,
    required int currentSimilarTvPage,
  });

  Future<Either<Failure, TVKeywords>> getTVKeywords({
    required SingleTV tvShow,
  });
}
