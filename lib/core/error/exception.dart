import 'package:movies_application/core/network/news_error_message_model.dart';

import '../network/movies_error_message_model.dart';

class NewsServerException implements Exception {
  final NewsErrorMessageModel newsErrorMessageModel;

  const NewsServerException({
    required this.newsErrorMessageModel,
  });
}

class MoviesServerException implements Exception {
  final MoviesErrorMessageModel moviesErrorMessageModel;

  MoviesServerException({
    required this.moviesErrorMessageModel,
  });
}

class LocalDatabaseException implements Exception {
  final String message;

  LocalDatabaseException({
    required this.message,
  });
}
