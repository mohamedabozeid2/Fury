import 'package:dartz/dartz.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/tv_keywords.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';

import '../../../../core/error/failure.dart';

class GetTVShowKeywordsUseCase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTVShowKeywordsUseCase(this.baseMoviesRepository);

  Future<Either<Failure, TVKeywords>> execute(
      {required SingleTV tvShow}) async {
    return await baseMoviesRepository.getTVKeywords(
      tvShow: tvShow,
    );
  }
}
