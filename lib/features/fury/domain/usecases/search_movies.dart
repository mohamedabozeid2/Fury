import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class SearchMoviesUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  SearchMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute({
    required String searchContent,
    required int page,
    bool includeAdult = true,
  }) async {
    return await baseMoviesRepository.searchMovie(
      page: page,
      searchContent: searchContent,
    );
  }
}
