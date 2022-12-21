import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetTrendingMoviesDataUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTrendingMoviesDataUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute(
      {required int currentTrendingPage}) async {
    return await baseMoviesRepository.getTrendingMoviesData(
        currentTrendingPage: currentTrendingPage);
  }
}
