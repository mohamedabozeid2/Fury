import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/news_item.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_news_repository.dart';

class GetScienceNewsUseCase{
  final BaseMoviesNewsRepository baseMoviesNewsRepository;

  GetScienceNewsUseCase(this.baseMoviesNewsRepository);

  Future<Either<Failure, NewsItem>> execute ()async{
    return await baseMoviesNewsRepository.getScienceNews();
  }

}