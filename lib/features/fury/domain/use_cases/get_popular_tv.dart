import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetPopularTvUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularTvUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute({required int currentPopularTvPage}) async {
    return await baseMoviesRepository.getPopularTv(
      currentPopularTvPage: currentPopularTvPage,
    );
  }
}
