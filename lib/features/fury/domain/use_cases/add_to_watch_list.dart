import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../entities/favorite_data.dart';

class AddToWatchListUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  AddToWatchListUseCase(this.baseMoviesRepository);

  Future<Either<Failure, FavoriteData>> execute({
    required String accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchList,
  }) async {
    return await baseMoviesRepository.addToWatchList(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      watchList: watchList,
    );
  }
}
