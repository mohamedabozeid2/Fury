import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

class GetPopularMoviesDataUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesDataUseCase(this.baseMoviesRepository);

  Future<Either<Failure, Movies>> execute(
      {required int currentPopularPage}) async {
    return await baseMoviesRepository.getPopularMoviesData(
        currentPopularPage: currentPopularPage);
  }
}
