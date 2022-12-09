import 'package:equatable/equatable.dart';
import 'package:movies_application/features/fury/data/models/movie_keywords_data_model.dart';

class MovieKeywords extends Equatable{
  final int id;
  final List<MovieKeywordsDataModel> keywords;

  const MovieKeywords({
    required this.keywords,
    required this.id,
});

  @override
  // TODO: implement props
  List<Object?> get props => [
    keywords,
    id,
  ];

}

// class MovieKeywords{
//   int? id;
//   List<KeywordsData> keywords = [];
//
//   MovieKeywords({required this.id, required this.keywords});
//
//   MovieKeywords.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     json['keywords'].forEach((element){
//       keywords.add(KeywordsData.fromJson(element));
//     });
//   }
// }
//
//
// class KeywordsData{
//   int? id;
//   String? name;
//
//   KeywordsData.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//   }
// }