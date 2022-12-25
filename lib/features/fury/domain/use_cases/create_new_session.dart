import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/session_id.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class CreateNewSessionUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  CreateNewSessionUseCase(this.baseMoviesRepository);

  Future<Either<Failure, SessionId>> execute({
    required String requestToken,
  }) async {
    return await baseMoviesRepository.createNewSession(
        requestToken: requestToken);
  }
}
