import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/news_item.dart';
import '../../domain/repositories/base_movies_news_repository.dart';
import '../data_sources/movies_news_remote_data_source.dart';

class MoviesNewsRepository extends BaseMoviesNewsRepository {
  final BaseMoviesNewsRemoteDataSource baseMoviesNewsRemoteDataSource;

  MoviesNewsRepository(this.baseMoviesNewsRemoteDataSource);

  @override
  Future<Either<Failure, NewsItem>> getMoviesNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getMoviesNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getBusinessNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getBusinessNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getGeneralNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getGeneralNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getHealthNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getHealthNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getScienceNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getScienceNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getSportsNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getSportsNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getTechnologyNews() async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.getTechnologyNews();
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> loadMoreNews(
      {required String category, required int page}) async {
    try {
      final result = await baseMoviesNewsRemoteDataSource.loadMoreNews(
          category: category, page: page);
      return Right(result);
    } on NewsServerException catch (failure) {

      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }
}
