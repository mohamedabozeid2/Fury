import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/movies.dart';

class GetFavoriteMoviesUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetFavoriteMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute({
    required String accountId,
    required String sessionId,
    required int currentFavoriteMoviesPage,
  }) async {
    return await baseMoviesRepository.getFavoriteMovies(
      accountId: accountId,
      sessionId: sessionId,
      currentFavoriteMoviesPage: currentFavoriteMoviesPage,
    );
  }
}
