import 'package:dartz/dartz.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class LoadMoreMoviesUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  LoadMoreMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute({
    required int currentPage,
    required String endPoint,
  }) async {
    return await baseMoviesRepository.loadMoreMovies(
      currentPage: currentPage, endPoint: endPoint,);
  }
}