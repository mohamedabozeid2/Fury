import 'package:movies_application/features/fury/data/models/movie_keywords_data_model.dart';
import 'package:movies_application/features/fury/domain/entities/movie_keywards.dart';

class MovieKeywordsModel extends MovieKeywords {
  const MovieKeywordsModel({required super.keywords, required super.id});

  factory MovieKeywordsModel.fromJson(Map<String, dynamic> json) {
    return MovieKeywordsModel(
      keywords: List<MovieKeywordsDataModel>.from(
        json['keywords'].map(
          (e) => MovieKeywordsDataModel.fromJson(e),
        ),
      ),
      id: json['id'],
    );
  }
}
