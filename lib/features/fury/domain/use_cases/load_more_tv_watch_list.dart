import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class LoadMoreTvWatchListUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  LoadMoreTvWatchListUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute({
    required int currentPage,
    required String accountId,
    required String sessionId,
  }) async {
    return await baseMoviesRepository.loadMoreTvWatchList(
      currentPage: currentPage,
      accountId: accountId,
      sessionId: sessionId,
    );
  }
}
