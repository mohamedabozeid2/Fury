import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/favorite_data.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class MarkAsFavoriteUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  MarkAsFavoriteUseCase(this.baseMoviesRepository);

  Future<Either<Failure, FavoriteData>> execute({
    required String accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    return await baseMoviesRepository.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      favorite: favorite,
    );
  }
}
