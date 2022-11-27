import 'package:movies_application/features/fury/data/models/single_news_model.dart';

import '../../domain/entities/news_item.dart';

class MoviesNewsModel extends NewsItem {
  const MoviesNewsModel({
    required super.status,
    required super.totalResults,
    required super.articles,
  });

  factory MoviesNewsModel.fromJson(Map<String, dynamic> json) {
    return MoviesNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<SingleNewsModel>.from(json['articles'].map((e) => SingleNewsModel.fromJson(e)),
      ),

    );
  }
}
