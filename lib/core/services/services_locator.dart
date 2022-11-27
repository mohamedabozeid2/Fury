import 'package:get_it/get_it.dart';
import 'package:movies_application/features/fury/data/data_sources/movies_news_remote_data_source.dart';
import 'package:movies_application/features/fury/data/data_sources/movies_remote_data_source.dart';
import 'package:movies_application/features/fury/data/repositories/movies_repository.dart';
import 'package:movies_application/features/fury/data/repositories/news_repository.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_news_repository.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';
import 'package:movies_application/features/fury/domain/usecases/get_movies_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_popular_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/get_trending_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/get_upcoming_movies_data.dart';

import '../../features/fury/domain/usecases/get_top_rated_movies_data.dart';
import '../../features/fury/presentation/controller/home_cubit/home_cubit.dart';
import '../../features/fury/presentation/controller/news_cubit/news_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///// Cubit
    sl.registerFactory(() => NewsCubit(sl()));
    sl.registerFactory(() => MoviesCubit(sl(),sl(),sl(),sl()));

    /////Use Cases
    sl.registerLazySingleton(() => GetMoviesNewsUserCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetTrendingMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetUpcomingMoviesDataUseCase(sl()));

    ///// Repository
    sl.registerLazySingleton<BaseMoviesNewsRepository>(
      () => MoviesNewsRepository(sl()),
    );

    sl.registerLazySingleton<BaseMoviesRepository>(
      () => MoviesRepository(sl()),
    );

    ///// Data Source
    sl.registerLazySingleton<BaseMoviesNewsRemoteDataSource>(
      () => MoviesNewsRemoteDataSource(),
    );

    sl.registerLazySingleton<BaseMoviesRemoteDataSource>(
      () => MoviesRemoteDataSource(),
    );
  }
}
