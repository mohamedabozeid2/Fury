import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../data_sources/movies_remote_data_source.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource baseMoviesRemoteDataSource;

  MoviesRepository(this.baseMoviesRemoteDataSource);

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
      {required int currentTrendingPage}) async{
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
}
