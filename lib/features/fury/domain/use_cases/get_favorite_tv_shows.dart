import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetFavoriteTvShowsUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetFavoriteTvShowsUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute({
    required String accountId,
    required String sessionId,
    required int currentFavoriteTvShowsPage,
  }) async {
    return await baseMoviesRepository.getFavoriteTvShows(
      accountId: accountId,
      sessionId: sessionId,
      currentFavoriteTvShowsPage: currentFavoriteTvShowsPage,
    );
  }
}
