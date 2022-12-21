import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetGenresUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetGenresUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Genres>> execute() async {
    return await baseMoviesRepository.getGenres();
  }
}
