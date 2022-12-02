import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/news_item.dart';

abstract class BaseMoviesNewsRepository{
  Future<Either<Failure,NewsItem>> getMoviesNews();
  Future<Either<Failure,NewsItem>> getBusinessNews();
  Future<Either<Failure,NewsItem>> getGeneralNews();
  Future<Either<Failure,NewsItem>> getHealthNews();
  Future<Either<Failure,NewsItem>> getScienceNews();
  Future<Either<Failure,NewsItem>> getSportsNews();
  Future<Either<Failure,NewsItem>> getTechnologyNews();
}