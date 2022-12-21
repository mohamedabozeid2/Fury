import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetNowPlayingMoviesDataUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetNowPlayingMoviesDataUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute(
      {required int currentNowPlayingPage}) async {
    return await baseMoviesRepository.getNowPlayingMoviesData(
        currentNowPlayingPage: currentNowPlayingPage);
  }
}