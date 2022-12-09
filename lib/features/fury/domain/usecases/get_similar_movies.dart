
import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetSimilarMoviesUseCase{
  final BaseMoviesRepository baseMoviesRepository;

  GetSimilarMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>>execute({required SingleMovie movie, required int currentSimilarMoviesPage})async{
    return await baseMoviesRepository.getSimilarMovie(movie: movie,currentSimilarMoviesPage: currentSimilarMoviesPage);

  }
}