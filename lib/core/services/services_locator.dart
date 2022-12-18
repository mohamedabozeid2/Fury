import 'package:get_it/get_it.dart';
import 'package:movies_application/features/fury/data/data_sources/movies_news_remote_data_source.dart';
import 'package:movies_application/features/fury/data/data_sources/movies_remote_data_source.dart';
import 'package:movies_application/features/fury/data/repositories/movies_repository.dart';
import 'package:movies_application/features/fury/data/repositories/news_repository.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_news_repository.dart';
import 'package:movies_application/features/fury/domain/repositories/base_movies_repository.dart';
import 'package:movies_application/features/fury/domain/usecases/get_business_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_general_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_genres.dart';
import 'package:movies_application/features/fury/domain/usecases/get_health_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_movie_keywords.dart';
import 'package:movies_application/features/fury/domain/usecases/get_movies_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_now_playing_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/get_popular_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/get_science_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_sports_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_technology_news.dart';
import 'package:movies_application/features/fury/domain/usecases/get_trending_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/get_upcoming_movies_data.dart';
import 'package:movies_application/features/fury/domain/usecases/load_more_news.dart';

import '../../features/fury/domain/usecases/get_similar_movies.dart';
import '../../features/fury/domain/usecases/get_similar_tv_shows.dart';
import '../../features/fury/domain/usecases/get_top_rated_movies_data.dart';
import '../../features/fury/domain/usecases/get_tv_airing_today.dart';
import '../../features/fury/domain/usecases/get_tv_show_keywords.dart';
import '../../features/fury/domain/usecases/search_movies.dart';
import '../../features/fury/presentation/controller/home_cubit/home_cubit.dart';
import '../../features/fury/presentation/controller/news_cubit/news_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///// Cubit
    sl.registerFactory(() => NewsCubit(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));
    sl.registerFactory(() => MoviesCubit(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
      sl(),
        ));

    /////Use Cases
    //// News
    sl.registerLazySingleton(() => GetMoviesNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetBusinessNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetGeneralNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetHealthNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetScienceNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetSportsNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetTechnologyNewsUseCase(sl()));
    sl.registerLazySingleton(() => LoadMoreNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetSimilarTVShowsUseCase(sl()));

    //// Movies
    sl.registerLazySingleton(() => GetPopularMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetTrendingMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetUpcomingMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetNowPlayingMoviesDataUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieKeywordUseCase(sl()));
    sl.registerLazySingleton(() => GetSimilarMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetGenresUseCase(sl()));
    sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTvAiringTodayUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowKeywordsUseCase(sl()));

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
