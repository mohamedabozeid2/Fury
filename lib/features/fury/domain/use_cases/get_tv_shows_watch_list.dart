import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetTvShowWatchListUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTvShowWatchListUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute({
    required String accountId,
    required String sessionId,
    required int currentTvShowsWatchListPage,
  }) async {
    return await baseMoviesRepository.getTvShowsWatchList(
      accountId: accountId,
      sessionId: sessionId,
      currentTvShowsWatchListPage: currentTvShowsWatchListPage,
    );
  }
}
