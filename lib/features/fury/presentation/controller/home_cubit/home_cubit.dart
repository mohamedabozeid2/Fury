import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/HomeScreen.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/movies_model.dart';
import '../../../domain/entities/movie_keywards.dart';
import '../../../domain/entities/movies.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_keywords.dart';
import '../../../domain/entities/user_data.dart';
import '../../../domain/usecases/get_genres.dart';
import '../../../domain/usecases/get_movie_keywords.dart';
import '../../../domain/usecases/get_now_playing_movies_data.dart';
import '../../../domain/usecases/get_popular_movies_data.dart';
import '../../../domain/usecases/get_similar_movies.dart';
import '../../../domain/usecases/get_similar_tv_shows.dart';
import '../../../domain/usecases/get_top_rated_movies_data.dart';
import '../../../domain/usecases/get_trending_movies_data.dart';
import '../../../domain/usecases/get_tv_airing_today.dart';
import '../../../domain/usecases/get_tv_show_keywords.dart';
import '../../../domain/usecases/get_upcoming_movies_data.dart';
import '../../../../../core/keys/movies_category_keys.dart';
import '../../../domain/usecases/search_movies.dart';
import '../../screens/my_movies_screen/my_movies_screen.dart';
import '../../screens/news_screen/news_screen.dart';
import '../../screens/settings/settings_screen.dart';
import 'home_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  final GetPopularMoviesDataUseCase getPopularMoviesDataUseCase;
  final GetTrendingMoviesDataUseCase getTrendingMoviesDataUseCase;
  final GetTopRatedMoviesDataUseCase getTopRatedMoviesDataUseCase;
  final GetUpcomingMoviesDataUseCase getUpcomingMoviesDataUseCase;
  final GetMovieKeywordUseCase getMovieKeywordUseCase;
  final GetSimilarMoviesUseCase getSimilarMoviesUseCase;
  final GetGenresUseCase getGenresUseCase;
  final SearchMoviesUseCase searchMovieUseCase;
  final GetNowPlayingMoviesDataUseCase getNowPlayingMoviesDataUseCase;
  final GetTvAiringTodayUseCase getTvAiringTodayUseCase;
  final GetSimilarTVShowsUseCase getSimilarTVShowsUseCase;
  final GetTVShowKeywordsUseCase getTVShowKeywordsUseCase;

  MoviesCubit(
    this.getPopularMoviesDataUseCase,
    this.getTopRatedMoviesDataUseCase,
    this.getUpcomingMoviesDataUseCase,
    this.getTrendingMoviesDataUseCase,
    this.getMovieKeywordUseCase,
    this.getSimilarMoviesUseCase,
    this.getGenresUseCase,
    this.searchMovieUseCase,
    this.getNowPlayingMoviesDataUseCase,
    this.getTvAiringTodayUseCase,
    this.getSimilarTVShowsUseCase,
    this.getTVShowKeywordsUseCase,
  ) : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  void changBotNavBar({required int index}) {
    botNavCurrentIndex = index;
    emit(ChangeBotNavBarState());
  }

  List<Widget> screens = [
    const HomeScreen(),
    MyMoviesScreen(),
    const NewsScreen(),
    SettingsScreen(),
  ];

  List<GButton> bottomNavItems = [
    const GButton(icon: Icons.home, text: AppStrings.home),
    const GButton(icon: Icons.movie_filter_outlined, text: AppStrings.movies),
    const GButton(icon: Icons.newspaper, text: AppStrings.news),
    const GButton(icon: Icons.settings, text: AppStrings.settings),
  ];

  void getUserData({
    required String userID,
    bool fromHomeScreen = false,
  }) {
    if (!fromHomeScreen) {
      emit(GetUserDataLoadingState());
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      userModel = UserData.fromJson(value.data()!);
      if (!fromHomeScreen) {
        emit(GetUserDataSuccessState());
      }
    }).catchError((error) {
      debugPrint("Error ===> ${error.toString()}");
      emit(GetUserDataErrorState());
    });
  }

  void getAllMovies({required BuildContext context}) {
    emit(GetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        Future.wait([
          ///////// POPULAR MOVIES //////////
          getPopularMovies().then((value) {
            value.fold((l) {
              emit(GetPopularMoviesErrorState(message: l.message));
            }, (r) {
              popularMovies = r;
              isFirstPopularLoadRunning = false;
            });
          }),
          ///////// TRENDING MOVIES //////////
          getTrendingMovies().then((value) {
            value.fold((l) {
              emit(GetTrendingMoviesErrorState(message: l.message));
            }, (r) {
              isFirstTrendingLoadRunning = false;
              trendingMovies = r;
            });
          }),
          ///////// TOP RATED MOVIES //////////
          getTopRatedMovies().then((value) {
            value.fold((l) {
              emit(GetTopRatedMoviesErrorState(message: l.message));
            }, (r) {
              topRatedMovies = r;
              isFirstTopRatedLoadRunning = false;
            });
          }),
          ///////// UPCOMING MOVIES //////////
          getUpComingMovies().then((value) {
            value.fold((l) {
              emit(GetUpComingMoviesErrorState(message: l.message));
            }, (r) {
              upComingMovies = r;
              isFirstUpComingLoadRunning = false;
            });
          }),

          getNowPlayingMovies().then((value) {
            value.fold((l) {
              emit(GetNowPlayingMoviesErrorState(message: l.message));
            }, (r) {
              nowPlayingMovies = r;
              isFirstNowPlayingLoadRunning = false;
            });
          }),
          getTvAiringToday().then((value) {
            value.fold((l) {
              emit(GetTvAiringTodayErrorState(message: l.message));
            }, (r) {
              isFirstTvAiringTodayLoadRunning = false;
              tvAiringToday = r;
            });
          })
        ]).then((value) {
          getMovieGenres().then((value) {
            value.fold((l) {
              emit(GetGenresErrorState(l.message));
            }, (r) {
              genresModel = r;
            });
            emit(GetAllMoviesSuccessState());
          });
        }).catchError((error) {
          Components.navigateAndFinish(
              context: context, widget: NoInternetScreen());
          debugPrint('error ======================> ${error.toString()}');
          emit(GetAllMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
        Components.navigateAndFinish(
            context: context, widget: NoInternetScreen());
        Components.showSnackBar(
            title: AppStrings.appName,
            message: AppStrings.noInternet,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    });
  }

  /////////// Popular Movies ////////////
  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Either<Failure, Movies>> getPopularMovies() async {
    isFirstPopularLoadRunning = true;
    return await getPopularMoviesDataUseCase.execute(
        currentPopularPage: currentPopularPage);
  }

  ///////////// Top Rated Movies ////////////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Either<Failure, Movies>> getTopRatedMovies() async {
    isFirstTopRatedLoadRunning = true;
    return await getTopRatedMoviesDataUseCase.execute(
        currentTopRatedPage: currentTopRatedPage);
  }

  ///////////// Trending Movies ////////////
  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Either<Failure, Movies>> getTrendingMovies() async {
    isFirstTrendingLoadRunning = true;
    return await getTrendingMoviesDataUseCase.execute(
        currentTrendingPage: currentTrendingPage);
  }

  ///////////// Up Coming Movies ////////////
  int currentUpComingPage = 1;
  bool isFirstUpComingLoadRunning = false;

  Future<Either<Failure, Movies>> getUpComingMovies() async {
    isFirstUpComingLoadRunning = true;
    return await getUpcomingMoviesDataUseCase.execute(
        currentUpComingPage: currentUpComingPage);
  }

  /////// Now PLaying Movies ////////////
  int currentNowPlayingPage = 1;
  bool isFirstNowPlayingLoadRunning = false;

  Future<Either<Failure, Movies>> getNowPlayingMovies() async {
    isFirstNowPlayingLoadRunning = true;
    return await getNowPlayingMoviesDataUseCase.execute(
      currentNowPlayingPage: currentNowPlayingPage,
    );
  }

  /////// TV Airing Today ///////////
  bool isFirstTvAiringTodayLoadRunning = false;
  int currentTvAiringTodayPage = 1;

  Future<Either<Failure, Tv>> getTvAiringToday() async {
    isFirstTvAiringTodayLoadRunning = true;
    return await getTvAiringTodayUseCase.execute(
      currentTvAiringTodayPage: currentTvAiringTodayPage,
    );
  }

  void loadMoreTVShows({
    required int page,
    required String tvCategory,
    required bool hasMorePages,
    required bool isLoadingMore,
    int? tvID,
  }) {
    emit(LoadMoreMoviesLoadingState());
    bool hasNextPage = hasMorePages;
    bool isLoadingMoreRunning = isLoadingMore;
    late String endPoint;
    List<SingleMovie> more = [];
  }

  void loadMoreMovies({
    required int page,
    required String moviesCategory,
    required bool hasMorePages,
    required bool isLoadingMore,
    int? movieID,
  }) {
    emit(LoadMoreMoviesLoadingState());
    bool hasNextPage = hasMorePages;
    bool isLoadingMoreRunning = isLoadingMore;
    late String endPoint;
    List<SingleMovie> more = [];

    if (hasNextPage && !isLoadingMoreRunning /*&& !isFirstLoadRunning*/) {
      isLoadingMoreRunning = true;
      more = [];
      if (moviesCategory == MoviesCategoryKeys.popular) {
        currentPopularPage++;
        endPoint = EndPoints.popular;
      } else if (moviesCategory == MoviesCategoryKeys.trending) {
        currentTrendingPage++;
        endPoint = EndPoints.trendingMovies;
      } else if (moviesCategory == MoviesCategoryKeys.topRated) {
        currentTopRatedPage++;
        endPoint = EndPoints.topRated;
      } else if (moviesCategory == MoviesCategoryKeys.upComing) {
        currentUpComingPage++;
        endPoint = EndPoints.upComing;
      } else if (moviesCategory == MoviesCategoryKeys.similarMovies) {
        currentSimilarMoviesPage++;
        endPoint = '/movie/$movieID/recommendations';
      } else if (moviesCategory == MoviesCategoryKeys.nowPlaying) {
        currentNowPlayingPage++;
        endPoint = EndPoints.nowPlaying;
      }
      // else if (moviesCategory == TVCategoryKeys.tvAiringToday) {
      //   currentTvAiringTodayPage++;
      //   endPoint = EndPoints.tvAiringToday;
      // }
      // else if (moviesCategory == TVCategoryKeys.similarTVShows) {
      //   currentSimilarTVShowPage++;
      //   endPoint = '/tv/$movieID/recommendations';
      // }
      MoviesDioHelper.getData(
              url: endPoint,
              query: {'api_key': MoviesDioHelper.apiKey, 'page': page + 1})
          .then((value) {
        if (moviesCategory == MoviesCategoryKeys.popular) {
          morePopularMovies = MoviesModel.fromJson(value.data);
          if (morePopularMovies!.moviesList.isNotEmpty) {
            more.addAll(morePopularMovies!.moviesList);
            popularMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.trending) {
          moreTrendingMovies = MoviesModel.fromJson(value.data);
          if (moreTrendingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTrendingMovies!.moviesList);
            trendingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.topRated) {
          moreTopRatedMovies = MoviesModel.fromJson(value.data);
          if (moreTopRatedMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTopRatedMovies!.moviesList);
            topRatedMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.upComing) {
          moreUpComingMovies = MoviesModel.fromJson(value.data);
          if (moreUpComingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreUpComingMovies!.moviesList);
            upComingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.nowPlaying) {
          moreNowPlayingMovies = MoviesModel.fromJson(value.data);
          if (moreNowPlayingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreNowPlayingMovies!.moviesList);
            nowPlayingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == MoviesCategoryKeys.similarMovies) {
          moreSimilarMovies = MoviesModel.fromJson(value.data);
          if (moreSimilarMovies!.moviesList.isNotEmpty) {
            more.addAll(moreSimilarMovies!.moviesList);
            similarMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
            debugPrint('no more');
          }
        }
        emit(LoadMoreMoviesSuccessState());
      }).catchError((error) {
        debugPrint('Error from load more movies ===> ${error.toString()}');
        emit(LoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }

  MovieKeywords? movieKeywords;
  TVKeywords? tvKeywords;

  Future<Either<Failure, MovieKeywords>> getMovieKeyword(
      {required SingleMovie movie}) async {
    return await getMovieKeywordUseCase.execute(movie: movie);
  }

  Future<Either<Failure, TVKeywords>> getTvShowKeywords(
      {required SingleTV tvShow}) async {
    return await getTVShowKeywordsUseCase.execute(tvShow: tvShow);
  }

  Genres? genresModel;

  Future<Either<Failure, Genres>> getMovieGenres() async {
    return await getGenresUseCase.execute();
  }

  List<String> genresList = [];

  Future<void> fillGenresList({required List<int> movieGenresId}) async {
    genresList = [];
    if (genresModel != null) {
      for (int i = 0; i < genresModel!.genres.length; i++) {
        if (movieGenresId.contains(genresModel!.genres[i].id)) {
          genresList.add(genresModel!.genres[i].name);
        }
      }
    }
  }

  void getTvDetailsData({required SingleTV tvShow}) {
    tvKeywords = null;
    genresList = [];
    similarTvShows = null;
    Future.wait([
      getSimilarTvShow(tvShow: tvShow).then((value) {
        value.fold((l) {
          emit(GetSimilarMoviesErrorState(l.message));
        }, (r) {
          similarTvShows = r;
        });
      }),
      getTvShowKeywords(tvShow: tvShow).then((value) {
        value.fold((l) {
          emit(GetSimilarMoviesErrorState(l.message));
        }, (r) {
          tvKeywords = r;
        });
      })
    ]).then((value) {
      fillGenresList(movieGenresId: tvShow.genresIds).then((value) {
        emit(GetMovieDetailsSuccessState());
      });
    });
  }

  void getMovieDetailsData({required SingleMovie movie}) {
    emit(GetMovieDetailsLoadingState());
    movieKeywords = null;
    genresList = [];
    similarMovies = null;
    Future.wait<void>([
      getSimilarMovies(movie: movie).then((value) {
        value.fold((l) {
          emit(GetSimilarMoviesErrorState(l.message));
        }, (r) {
          similarMovies = r;
        });
      }),
      getMovieKeyword(movie: movie).then((value) {
        value.fold((l) {
          emit(GetMoviesKeywordsErrorState(l.message));
        }, (r) {
          movieKeywords = r;
        });
      }),
    ]).then((value) {
      fillGenresList(movieGenresId: movie.genresIds).then((value) {
        emit(GetMovieDetailsSuccessState());
      });
    }).catchError((error) {
      debugPrint("Error in get movie details ${error.toString()}");
      emit(GetMovieDetailsErrorState());
    });
  }

  int currentSimilarMoviesPage = 1;

  Future<Either<Failure, Movies>> getSimilarMovies(
      {required SingleMovie movie}) async {
    currentSimilarMoviesPage = 1;
    return await getSimilarMoviesUseCase.execute(
      movie: movie,
      currentSimilarMoviesPage: currentSimilarMoviesPage,
    );
  }

  int currentSimilarTVShowPage = 1;

  Future<Either<Failure, Tv>> getSimilarTvShow(
      {required SingleTV tvShow}) async {
    emit(GetMovieDetailsLoadingState());
    currentSimilarTVShowPage = 1;
    return await getSimilarTVShowsUseCase.execute(
      tvShow: tvShow,
      currentSimilarTvPage: currentSimilarTVShowPage,
    );
  }

  Movies? searchMovies;

  void searchMovie({required String searchContent, required int page}) {
    emit(SearchMoviesLoadingState());
    searchMovies = null;
    final result =
        searchMovieUseCase.execute(searchContent: searchContent, page: page);
    result.then((value) {
      value.fold((l) {
        emit(SearchMoviesErrorState(l.message));
      }, (r) {
        searchMovies = r;
        emit(SearchMoviesSuccessState());
      });
    });
  }
}
