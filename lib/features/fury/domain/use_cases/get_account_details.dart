import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/account_details.dart';

import '../../../../core/error/failure.dart';
import '../repositories/base_movies_repository.dart';

class GetAccountDetailsUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetAccountDetailsUseCase(this.baseMoviesRepository);

  Future<Either<Failure, AccountDetails>> execute({
    required String sessionId,
  }) async {
    return await baseMoviesRepository.getAccountDetails(sessionId: sessionId);
  }
}
