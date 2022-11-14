import 'package:movies_application/features/fury/domain/entities/news_item.dart';
import 'package:movies_application/features/fury/domain/repositories/movies_news_repository.dart';

class GetMoviesNews{
  final MoviesNewsRepository repository;
  GetMoviesNews({required this.repository});

  Future<NewsItem> execute()async{
    return await repository.getMoviesNews();
  }
}