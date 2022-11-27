import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetUpcomingMoviesDataUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetUpcomingMoviesDataUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute(
      {required int currentUpComingPage}) async {
    return await baseMoviesRepository.getUpcomingMoviesData(
        currentUpComingPage: currentUpComingPage);
  }
}
