import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movie_keywards.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../data/models/single_movie.dart';

class GetMovieKeywordUseCase{
  final BaseMoviesRepository baseMoviesRepository;
  GetMovieKeywordUseCase(this.baseMoviesRepository);

  Future<Either<Failure, MovieKeywords>>execute({required SingleMovie movie})async{
    return await baseMoviesRepository.getMovieKeywords(movie: movie);
  }
}