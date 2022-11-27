import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/news_item.dart';
import '../../domain/repositories/base_movies_news_repository.dart';
import '../data_sources/movies_news_remote_data_source.dart';


class MoviesNewsRepository extends BaseMoviesNewsRepository{
  final BaseMoviesNewsRemoteDataSource baseMoviesNewsRemoteDataSource;

  MoviesNewsRepository(this.baseMoviesNewsRemoteDataSource);

  @override
  Future<Either<Failure,NewsItem>> getMoviesNews() async{
    final result = await baseMoviesNewsRemoteDataSource.getMoviesNews();
    try{
      return Right(result);
    } on NewsServerException catch(failure){
      return Left(ServerFailure(failure.newsErrorMessageModel.message));
    }

  }

}