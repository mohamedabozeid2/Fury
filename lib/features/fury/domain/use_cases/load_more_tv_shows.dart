import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class LoadMoreTVShowsUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  LoadMoreTVShowsUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Tv>> execute({
    required int currentPage,
    required String endPoint,
  }) async {
    return await baseMoviesRepository.loadMoreTVShows(
      currentPage: currentPage,
      endPoint: endPoint,
    );
  }
}
