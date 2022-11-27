import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';

class MoviesModel extends Movies {
  const MoviesModel(
      {required super.page,
      required super.moviesList,
      required super.totalPages,
      required super.totalResult});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'],
      moviesList: List<SingleMovie>.from(
        json['results'].map(
          (e) => SingleMovie.fromJson(e),
        ),
      ),
      totalPages: json['total_pages'],
      totalResult: json['total_results'],
    );
  }
}
