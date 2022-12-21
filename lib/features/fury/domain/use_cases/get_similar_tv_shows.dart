import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetSimilarTVShowsUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetSimilarTVShowsUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute(
      {required SingleTV tvShow, required int currentSimilarTvPage}) async {
    return await baseMoviesRepository.getSimilarTVShows(
      tvShow: tvShow,
      currentSimilarTvPage: currentSimilarTvPage,
    );
  }
}
