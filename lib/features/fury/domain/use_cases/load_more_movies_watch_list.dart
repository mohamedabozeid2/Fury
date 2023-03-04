import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';

import '../repositories/base_movies_repository.dart';

class LoadMoreMoviesWatchListUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  LoadMoreMoviesWatchListUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute({
    required int currentPage,
    required String accountId,
    required String sessionId,
  }) async {
    return await baseMoviesRepository.loadMoreMoviesWatchList(
      currentPage: currentPage,
      sessionId: sessionId,
      accountId: accountId,
    );
  }
}
