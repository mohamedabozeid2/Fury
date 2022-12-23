import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';

class MoviesModel extends Movies {
  const MoviesModel({
    required super.page,
    required super.moviesList,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'],
      moviesList: List<SingleMovie>.from(
        json['results'].map(
          (e) => SingleMovie.fromJson(e),
        ),
      ),
    );
  }
}
