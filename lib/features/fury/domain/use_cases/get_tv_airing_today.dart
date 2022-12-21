import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetTvAiringTodayUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTvAiringTodayUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute(
      {required int currentTvAiringTodayPage}) async {
    return await baseMoviesRepository.getAiringToday(
        currentTvAiringTodayPage: currentTvAiringTodayPage);
  }
}
