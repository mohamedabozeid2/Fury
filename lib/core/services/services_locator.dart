import 'package:get_it/get_it.dart';
import 'package:movies_application/features/fury/domain/use_cases/add_to_watch_list.dart';
import 'package:movies_application/features/fury/domain/use_cases/get_movies_watch_list.dart';

import '../../features/fury/data/data_sources/movies_news_remote_data_source.dart';
import '../../features/fury/data/data_sources/movies_remote_data_source.dart';
import '../../features/fury/data/repositories/movies_repository.dart';
import '../../features/fury/data/repositories/news_repository.dart';
import '../../features/fury/domain/repositories/base_movies_news_repository.dart';
import '../../features/fury/domain/repositories/base_movies_repository.dart';
import '../../features/fury/domain/use_cases/create_new_session.dart';
import '../../features/fury/domain/use_cases/create_session_with_login.dart';
import '../../features/fury/domain/use_cases/get_account_details.dart';
import '../../features/fury/domain/use_cases/get_business_news.dart';
import '../../features/fury/domain/use_cases/get_general_news.dart';
import '../../features/fury/domain/use_cases/get_genres.dart';
import '../../features/fury/domain/use_cases/get_health_news.dart';
import '../../features/fury/domain/use_cases/get_movie_keywords.dart';
import '../../features/fury/domain/use_cases/get_movies_news.dart';
import '../../features/fury/domain/use_cases/get_now_playing_movies_data.dart';
import '../../features/fury/domain/use_cases/get_popular_movies_data.dart';
import '../../features/fury/domain/use_cases/get_science_news.dart';
import '../../features/fury/domain/use_cases/get_similar_movies.dart';
import '../../features/fury/domain/use_cases/get_similar_tv_shows.dart';
import '../../features/fury/domain/use_cases/get_sports_news.dart';
import '../../features/fury/domain/use_cases/get_technology_news.dart';
import '../../features/fury/domain/use_cases/get_top_rated_movies_data.dart';
import '../../features/fury/domain/use_cases/get_top_rated_tv.dart';
import '../../features/fury/domain/use_cases/get_trending_movies_data.dart';
import '../../features/fury/domain/use_cases/get_tv_airing_today.dart';
import '../../features/fury/domain/use_cases/get_popular_tv.dart';
import '../../features/fury/domain/use_cases/get_tv_show_keywords.dart';
import '../../features/fury/domain/use_cases/get_tv_shows_watch_list.dart';
import '../../features/fury/domain/use_cases/get_upcoming_movies_data.dart';
import '../../features/fury/domain/use_cases/load_more_movies.dart';
import '../../features/fury/domain/use_cases/load_more_news.dart';
import '../../features/fury/domain/use_cases/load_more_tv_shows.dart';
import '../../features/fury/domain/use_cases/request_token_for_login.dart';
import '../../features/fury/domain/use_cases/search_movies.dart';
import '../../features/fury/presentation/controller/home_cubit/home_cubit.dart';
import '../../features/fury/presentation/controller/login_cubit/login_cubit.dart';
import '../../features/fury/presentation/controller/news_cubit/news_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///// Cubit

    sl.registerFactory(
      () => LoginCubit(
        sl(),
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerFactory(
      () => NewsCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ),
    );
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
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    /////Use Cases

    //// Login
    sl.registerLazySingleton(() => RequestTokenUseCase(sl()));
    sl.registerLazySingleton(() => CreateNewSessionUseCase(sl()));
    sl.registerLazySingleton(() => CreateSessionWithLoginUseCase(sl()));
    sl.registerLazySingleton(() => GetAccountDetailsUseCase(sl()));

    //// News
    sl.registerLazySingleton(() => GetMoviesNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetBusinessNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetGeneralNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetHealthNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetScienceNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetSportsNewsUseCase(sl()));
    sl.registerLazySingleton(() => GetTechnologyNewsUseCase(sl()));
    sl.registerLazySingleton(() => LoadMoreNewsUseCase(sl()));

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
    sl.registerLazySingleton(() => GetSimilarTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => LoadMoreTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => LoadMoreMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularTvUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedTvUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesWatchListUseCase(sl()));
    sl.registerLazySingleton(() => GetTvShowWatchListUseCase(sl()));
    sl.registerLazySingleton(() => AddToWatchListUseCase(sl()));

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
