import 'package:movies_application/features/fury/data/models/movie_keywords_data_model.dart';

import '../../domain/entities/tv_keywords.dart';

class TVKeywordsModel extends TVKeywords {
  const TVKeywordsModel({required super.keywords, required super.id});

  factory TVKeywordsModel.fromJson(Map<String, dynamic> json) {
    return TVKeywordsModel(
      keywords: List<MovieKeywordsDataModel>.from(
        json['results'].map(
              (e) => MovieKeywordsDataModel.fromJson(e),
        ),
      ),
      id: json['id'],
    );
  }
}
