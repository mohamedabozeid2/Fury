import '../entities/news_item.dart';

abstract class MoviesNewsRepository{
  Future<NewsItem> getMoviesNews();
}