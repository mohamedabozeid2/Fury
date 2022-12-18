import 'package:equatable/equatable.dart';
import 'package:movies_application/features/fury/data/models/movie_keywords_data_model.dart';

class TVKeywords extends Equatable{
  final int id;
  final List<MovieKeywordsDataModel> keywords;

  const TVKeywords({
    required this.keywords,
    required this.id,
  });

  @override
  List<Object?> get props => [
    keywords,
    id,
  ];

}
