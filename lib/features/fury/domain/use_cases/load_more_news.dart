import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/news_item.dart';
import '../repositories/base_movies_news_repository.dart';

class LoadMoreNewsUseCase {
  final BaseMoviesNewsRepository baseMoviesNewsRepository;

  LoadMoreNewsUseCase(this.baseMoviesNewsRepository);

  Future<Either<Failure, NewsItem>> execute(
      {required String category, required int page}) async {
    return await baseMoviesNewsRepository.loadMoreNews(
        category: category, page: page);
  }
}
