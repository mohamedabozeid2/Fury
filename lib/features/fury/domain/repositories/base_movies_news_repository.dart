import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/news_item.dart';

abstract class BaseMoviesNewsRepository{
  Future<Either<Failure,NewsItem>> getMoviesNews();
}