import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';

import '../entities/movies.dart';

abstract class BaseMoviesRepository{
  Future<Either<Failure, Movies>> getPopularMoviesData({required int currentPopularPage});
  Future<Either<Failure, Movies>> getUpcomingMoviesData({required int currentUpComingPage});
  Future<Either<Failure, Movies>> getTrendingMoviesData({required int currentTrendingPage});
  Future<Either<Failure, Movies>> getTopRatedMoviesData({required int currentTopRatedPage});
}