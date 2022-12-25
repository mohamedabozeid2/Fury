import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/request_token.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class RequestTokenUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  RequestTokenUseCase(this.baseMoviesRepository);
 
  Future<Either<Failure, RequestToken>> execute() async {
    return await baseMoviesRepository.getRequestToken();
  }
}
