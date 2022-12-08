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
    final result = await baseMoviesNewsRemoteDataSource.getMoviesNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getBusinessNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getBusinessNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getGeneralNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getGeneralNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getHealthNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getHealthNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getScienceNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getScienceNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getSportsNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getSportsNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getTechnologyNews() async {
    final result = await baseMoviesNewsRemoteDataSource.getTechnologyNews();
    try {
      return Right(result);
    } on NewsServerException catch (failure) {
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, NewsItem>> loadMoreNews(
      {required String category, required int page}) async {
    final result =
        await baseMoviesNewsRemoteDataSource.loadMoreNews(category: category,page: page);
    try{
      return Right(result);
    }on NewsServerException catch(failure){
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }
  }
}
