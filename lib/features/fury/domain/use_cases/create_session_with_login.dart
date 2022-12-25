import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/request_token.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class CreateSessionWithLoginUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  CreateSessionWithLoginUseCase(this.baseMoviesRepository);

  Future<Either<Failure, RequestToken>> execute({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    return await baseMoviesRepository.createSessionWithLogin(
      userName: userName,
      password: password,
      requestToken: requestToken,
    );
  }
}
