import 'package:equatable/equatable.dart';

class SingleTV extends Equatable {
  final isMovie = false;
  final int id;
  final dynamic backdropPath;
  final dynamic posterPath;
  final String firstAirDate;
  final List<int> genresIds;
  final String? name;
  final String? originalName;
  final String language;
  final String description;
  final double voteAverage;

  const SingleTV(
      {required this.description,
      required this.posterPath,
      required this.name,
      required this.id,
      required this.genresIds,
      required this.language,
      required this.backdropPath,
      required this.firstAirDate,
      required this.originalName,
      required this.voteAverage,
      });

  factory SingleTV.fromJson(Map<String, dynamic> json) {
    return SingleTV(
      description: json['overview'],
      posterPath: json['poster_path'],
      name: json['name'],
      id: json['id'],
      genresIds: List<int>.from(json['genre_ids'].map((e) => e)),
      language: json['original_language'],
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      originalName: json['original_name'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        description,
        posterPath,
        name,
        id,
        genresIds,
        language,
        backdropPath,
        firstAirDate,
        originalName,
        voteAverage,
      ];
}
