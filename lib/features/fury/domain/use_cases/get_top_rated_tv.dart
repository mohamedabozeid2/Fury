import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class GetTopRatedTvUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedTvUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute(
      {required int currentTopRatedTvPage}) async {
    return await baseMoviesRepository.getTopRatedTv(
      currentTopRateTvPage: currentTopRatedTvPage,
    );
  }
}
