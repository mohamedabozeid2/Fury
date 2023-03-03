import 'package:equatable/equatable.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';

class SingleMovie extends Equatable {
  final String? name;
  final String? title;
  final int id;
  final String language;
  final bool isAdult;
  final String description;
  final dynamic posterPath;
  final String? releaseDate;
  final double rate;
  final dynamic backDropPath;
  final List<int> genresIds;


  const SingleMovie(
      {required this.name,
      required this.title,
      required this.id,
      required this.description,
      required this.rate,
      required this.genresIds,
      required this.backDropPath,
      required this.isAdult,
      required this.language,
      required this.posterPath,
      required this.releaseDate});

  factory SingleMovie.fromJson(Map<String, dynamic> json) {
    return SingleMovie(
      name: json['original_name'],
      title: json['original_title'],
      id: json['id'],
      description: json['overview'],
      rate: json['vote_average'].toDouble(),
      genresIds: List<int>.from(json['genre_ids'].map((e) => e)),
      backDropPath: json['backdrop_path'],
      isAdult: json['adult'],
      language: json['original_language'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }

  String posterURL() {
    return '${MoviesDioHelper.baseImageURL}$posterPath';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        id,
        language,
        description,
        rate,
        genresIds,
        backDropPath,
        posterPath,
        isAdult,
        releaseDate
      ];
}
