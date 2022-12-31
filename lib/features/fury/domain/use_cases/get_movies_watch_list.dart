import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetMoviesWatchList {
  final BaseMoviesRepository baseMoviesRepository;

  GetMoviesWatchList(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute({
    required String accountId,
    required String sessionId,
    required int currentMoviesWatchListPage,
  }) async {
    return await baseMoviesRepository.getMoviesWatchList(
      accountId: accountId,
      sessionId: sessionId,
      currentMoviesWatchListPage: currentMoviesWatchListPage,
    );
  }
}
