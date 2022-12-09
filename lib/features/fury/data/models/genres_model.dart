import 'package:movies_application/features/fury/data/models/genres_data_model.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';

class GenresModel extends Genres {
  const GenresModel({required super.genres});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      genres: List<GenresData>.from(
        json['genres'].map(
          (e) => GenresData.fromJson(e),
        ),
      ),
    );
  }
}
