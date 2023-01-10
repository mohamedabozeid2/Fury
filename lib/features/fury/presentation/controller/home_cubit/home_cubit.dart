import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/error/failure.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_screen/movies_screen.dart';

import '../../../../../core/keys/tv_category_keys.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/movie_keywords.dart';
import '../../../domain/entities/movies.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_keywords.dart';
import '../../../domain/use_cases/add_to_watch_list.dart';
import '../../../domain/use_cases/get_favorite_movies.dart';
import '../../../domain/use_cases/get_favorite_tv_shows.dart';
import '../../../domain/use_cases/get_genres.dart';
import '../../../domain/use_cases/get_movie_keywords.dart';
import '../../../domain/use_cases/get_movies_watch_list.dart';
import '../../../domain/use_cases/get_now_playing_movies_data.dart';
import '../../../domain/use_cases/get_popular_movies_data.dart';
import '../../../domain/use_cases/get_similar_movies.dart';
import '../../../domain/use_cases/get_similar_tv_shows.dart';
import '../../../domain/use_cases/get_top_rated_movies_data.dart';
import '../../../domain/use_cases/get_top_rated_tv.dart';
import '../../../domain/use_cases/get_trending_movies_data.dart';
import '../../../domain/use_cases/get_tv_airing_today.dart';
import '../../../domain/use_cases/get_popular_tv.dart';
import '../../../domain/use_cases/get_tv_show_keywords.dart';
import '../../../domain/use_cases/get_tv_shows_watch_list.dart';
import '../../../domain/use_cases/get_upcoming_movies_data.dart';
import '../../../../../core/keys/movies_category_keys.dart';
import '../../../domain/use_cases/load_more_movies.dart';
import '../../../domain/use_cases/load_more_tv_shows.dart';
import '../../../domain/use_cases/mark_as_favorite.dart';
import '../../../domain/use_cases/search_movies.dart';
import '../../screens/Layout/Layout.dart';
import '../../screens/news_screen/news_screen.dart';
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
  final GetPopularTvUseCase getPopularTvUseCase;
  final GetSimilarTVShowsUseCase getSimilarTVShowsUseCase;
  final GetTVShowKeywordsUseCase getTVShowKeywordsUseCase;
  final LoadMoreTVShowsUseCase loadMoreTVShowsUseCase;
  final LoadMoreMoviesUseCase loadMoreMoviesUseCase;
  final GetTopRatedTvUseCase getTopRatedTvUseCase;
  final AddToWatchListUseCase addToWatchListUseCase;
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;
  final GetFavoriteTvShowsUseCase getFavoriteTvShowsUseCase;
  final GetMoviesWatchListUseCase getMoviesWatchListUseCase;
  final GetTvShowWatchListUseCase getTvShowWatchListUseCase;
  final MarkAsFavoriteUseCase markAsFavoriteUseCase;

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
    this.loadMoreTVShowsUseCase,
    this.loadMoreMoviesUseCase,
    this.getPopularTvUseCase,
    this.getTopRatedTvUseCase,
    this.markAsFavoriteUseCase,
    this.addToWatchListUseCase,
    this.getFavoriteTvShowsUseCase,
    this.getFavoriteMoviesUseCase,
    this.getTvShowWatchListUseCase,
    this.getMoviesWatchListUseCase,
  ) : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  void changBotNavBar({required int index}) {
    botNavCurrentIndex = index;
    emit(ChangeBotNavBarState());
  }

  List<Widget> screens = [
    const MoviesScreen(),
    // const MyListsScreen(),
    const NewsScreen(),
    // const SettingsScreen(),
  ];

  // List<Widget>

  List<GButton> bottomNavItems = [
    const GButton(icon: Icons.home, text: AppStrings.home),
    // const GButton(icon: Icons.movie_filter_outlined, text: AppStrings.movies),
    const GButton(icon: Icons.newspaper, text: AppStrings.news),
    // const GButton(icon: Icons.settings, text: AppStrings.settings),
  ];

  void getAllMovies({required BuildContext context}) {
    emit(GetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        Future.wait([
          /// POPULAR MOVIES //////////
          getPopularMovies().then((value) {
            value.fold((l) {
              emit(GetPopularMoviesErrorState(message: l.message));
            }, (r) {
              popularMovies = r;
              isFirstPopularLoadRunning = false;
            });
          }),

          /// TRENDING MOVIES //////////
          getTrendingMovies().then((value) {
            value.fold((l) {
              emit(GetTrendingMoviesErrorState(message: l.message));
            }, (r) {
              isFirstTrendingLoadRunning = false;
              trendingMovies = r;
            });
          }),

          /// TOP RATED MOVIES //////////
          getTopRatedMovies().then((value) {
            value.fold((l) {
              emit(GetTopRatedMoviesErrorState(message: l.message));
            }, (r) {
              topRatedMovies = r;
              isFirstTopRatedLoadRunning = false;
            });
          }),

          /// UPCOMING MOVIES //////////
          getUpComingMovies().then((value) {
            value.fold((l) {
              emit(GetUpComingMoviesErrorState(message: l.message));
            }, (r) {
              upComingMovies = r;
              isFirstUpComingLoadRunning = false;
            });
          }),

          /// NOW PLAYING MOVIES //////////
          getNowPlayingMovies().then((value) {
            value.fold((l) {
              emit(GetNowPlayingMoviesErrorState(message: l.message));
            }, (r) {
              nowPlayingMovies = r;
              isFirstNowPlayingLoadRunning = false;
            });
          }),

          ///////// TV SHOWS MOVIES //////////

          /// TV Airing Today
          getTvAiringToday().then((value) {
            value.fold((l) {
              emit(GetTvAiringTodayErrorState(message: l.message));
            }, (r) {
              isFirstTvAiringTodayLoadRunning = false;
              tvAiringToday = r;
            });
          }),

          /// Popular Tv Shows
          getPopularTv().then((value) {
            value.fold((l) {
              emit(GetPopularTvErrorState(
                message: l.message,
              ));
            }, (r) {
              isFirstPopularTvLoadRunning = false;
              popularTv = r;
            });
          }),

          /// Top Rated Tv Shows
          getTopRatedTv().then((value) {
            value.fold((l) {
              emit(GetTopRatedTvErrorState(message: l.message));
            }, (r) {
              isFirstTopRatedTvLoadingRunning = false;
              topRatedTv = r;
            });
          }),

          // /// Favorite Movies
          // getFavoriteMovies().then((value) {
          //   value.fold((l) {
          //     emit(GetFavoriteMoviesErrorState(message: l.message));
          //   }, (r) {
          //     isFirstFavoriteMoviesLoadingRunning = false;
          //     favoriteMovies = r;
          //   });
          // }),

          /// Favorite Tv Shows
          // getFavoriteTvShows().then((value) {
          //   value.fold((l) {
          //     emit(GetFavoriteTvErrorState(
          //       message: l.message,
          //     ));
          //   }, (r) {
          //     isFirstFavoriteTvShowsLoadingRunning = false;
          //     favoriteTvShows = r;
          //   });
          // }),

          /// Movies Watch List
          getMoviesWatchList().then((value) {
            value.fold((l) {
              emit(GetMoviesWatchListErrorState(
                message: l.message,
              ));
            }, (r) {
              isFirstMoviesWatchListLoadingRunning = false;
              moviesWatchList = r;
            });
          }),

          /// Tv Shows Watch List
          getTvShowsWatchList().then((value) {
            value.fold((l) {
              emit(GetTvWatchListErrorState(
                message: l.message,
              ));
            }, (r) {
              isFirstTvShowsWatchListLoadingRunning = false;
              tvShowsWatchList = r;
            });
          }),
        ]).then((value) {
          /// Movies Genres
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
              context: context,
              widget: const NoInternetScreen(
                fromLogin: false,
              ));
          debugPrint('error ======================> ${error.toString()}');
          emit(GetAllMoviesErrorState());
        });
      } else {
        debugPrint('No Internet');
        Components.navigateAndFinish(
            context: context,
            widget: const NoInternetScreen(
              fromLogin: false,
            ));
        Components.showSnackBar(
            title: AppStrings.appName,
            message: AppStrings.noInternet,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
    });
  }

  /// Popular Movies ////////////
  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Either<Failure, Movies>> getPopularMovies() async {
    isFirstPopularLoadRunning = true;
    return await getPopularMoviesDataUseCase.execute(
        currentPopularPage: currentPopularPage);
  }

  /// Top Rated Movies ////////////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Either<Failure, Movies>> getTopRatedMovies() async {
    isFirstTopRatedLoadRunning = true;
    return await getTopRatedMoviesDataUseCase.execute(
        currentTopRatedPage: currentTopRatedPage);
  }

  /// Trending Movies ////////////
  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Either<Failure, Movies>> getTrendingMovies() async {
    isFirstTrendingLoadRunning = true;
    return await getTrendingMoviesDataUseCase.execute(
        currentTrendingPage: currentTrendingPage);
  }

  /// Up Coming Movies ////////////
  int currentUpComingPage = 1;
  bool isFirstUpComingLoadRunning = false;

  Future<Either<Failure, Movies>> getUpComingMovies() async {
    isFirstUpComingLoadRunning = true;
    return await getUpcomingMoviesDataUseCase.execute(
        currentUpComingPage: currentUpComingPage);
  }

  /// Now PLaying Movies ////////////
  int currentNowPlayingPage = 1;
  bool isFirstNowPlayingLoadRunning = false;

  Future<Either<Failure, Movies>> getNowPlayingMovies() async {
    isFirstNowPlayingLoadRunning = true;
    return await getNowPlayingMoviesDataUseCase.execute(
      currentNowPlayingPage: currentNowPlayingPage,
    );
  }

  /// TV Airing Today ///////////
  bool isFirstTvAiringTodayLoadRunning = false;
  int currentTvAiringTodayPage = 1;

  Future<Either<Failure, Tv>> getTvAiringToday() async {
    isFirstTvAiringTodayLoadRunning = true;
    return await getTvAiringTodayUseCase.execute(
      currentTvAiringTodayPage: currentTvAiringTodayPage,
    );
  }

  /// POPULAR TV /////////
  bool isFirstPopularTvLoadRunning = false;
  int currentPopularTvPage = 1;

  Future<Either<Failure, Tv>> getPopularTv() async {
    isFirstPopularTvLoadRunning = true;
    return await getPopularTvUseCase.execute(
      currentPopularTvPage: currentPopularTvPage,
    );
  }

  /// Top Rated TV ///////
  bool isFirstTopRatedTvLoadingRunning = false;
  int currentTopRatedTvPage = 1;

  Future<Either<Failure, Tv>> getTopRatedTv() async {
    isFirstTopRatedTvLoadingRunning = true;
    return await getTopRatedTvUseCase.execute(
      currentTopRatedTvPage: currentTopRatedTvPage,
    );
  }

  void loadMoreTVShows({
    required int page,
    required String tvCategory,
    required bool hasMorePages,
    required bool isLoadingMore,

    ///// For similar TV Shows ////////
    int? tvID,
  }) {
    emit(LoadMoreTvShowsLoadingState());
    bool hasNextPage = hasMorePages;
    bool isLoadingMoreRunning = isLoadingMore;
    late String endPoint;
    if (hasNextPage && !isLoadingMoreRunning) {
      isLoadingMoreRunning = true;
      if (tvCategory == TVCategoryKeys.similarTVShows) {
        currentSimilarTVShowPage++;
        endPoint = '/tv/$tvID/recommendations';
      } else if (tvCategory == TVCategoryKeys.tvAiringToday) {
        currentTvAiringTodayPage++;
        endPoint = EndPoints.tvAiringToday;
      } else if (tvCategory == TVCategoryKeys.popularTv) {
        currentPopularTvPage++;
        endPoint = EndPoints.popularTv;
      } else if (tvCategory == TVCategoryKeys.topRatedTv) {
        currentTopRatedPage++;
        endPoint = EndPoints.topRatedTv;
      }
      loadMoreTVShowsUseCase
          .execute(currentPage: page, endPoint: endPoint)
          .then((value) {
        value.fold((l) {
          emit(LoadMoreTvShowsErrorState());
        }, (r) {
          if (tvCategory == TVCategoryKeys.similarTVShows) {
            moreSimilarTvShows = r;
            if (moreSimilarTvShows!.tvList.isNotEmpty) {
              similarTvShows!.loadMoreMovies(tv: moreSimilarTvShows!.tvList);
            } else {
              hasNextPage = false;
            }
          } else if (tvCategory == TVCategoryKeys.tvAiringToday) {
            moreTvAiringToday = r;
            if (moreTvAiringToday!.tvList.isNotEmpty) {
              tvAiringToday!.loadMoreMovies(tv: moreTvAiringToday!.tvList);
            } else {
              hasNextPage = false;
            }
          } else if (tvCategory == TVCategoryKeys.popularTv) {
            morePopularTv = r;
            if (morePopularTv!.tvList.isNotEmpty) {
              popularTv!.loadMoreMovies(tv: morePopularTv!.tvList);
            } else {
              hasNextPage = false;
            }
          } else if (tvCategory == TVCategoryKeys.topRatedTv) {
            moreTopRatedTv = r;
            if (moreTopRatedTv!.tvList.isNotEmpty) {
              topRatedTv!.loadMoreMovies(tv: moreTopRatedTv!.tvList);
            } else {
              hasNextPage = false;
            }
          }
          emit(LoadMoreTvShowsSuccessState());
        });
      }).catchError((error) {
        debugPrint("Error in load more tv shows ===> ${error.toString()}");

        emit(LoadMoreTvShowsErrorState());
      });
      isLoadingMoreRunning = false;
    }
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

    if (hasNextPage && !isLoadingMoreRunning) {
      isLoadingMoreRunning = true;
      if (moviesCategory == MoviesCategoryKeys.popular) {
        currentPopularPage++;
        endPoint = EndPoints.popularMovies;
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
      loadMoreMoviesUseCase
          .execute(currentPage: page, endPoint: endPoint)
          .then((value) {
        value.fold((l) {
          emit(LoadMoreMoviesErrorState());
        }, (r) {
          if (moviesCategory == MoviesCategoryKeys.popular) {
            morePopularMovies = r;
            if (morePopularMovies!.moviesList.isNotEmpty) {
              popularMovies!
                  .loadMoreMovies(movies: morePopularMovies!.moviesList);
            } else {
              hasNextPage = false;
            }
          } else if (moviesCategory == MoviesCategoryKeys.trending) {
            moreTrendingMovies = r;
            if (moreTrendingMovies!.moviesList.isNotEmpty) {
              trendingMovies!
                  .loadMoreMovies(movies: moreTrendingMovies!.moviesList);
            } else {
              hasNextPage = false;
            }
          } else if (moviesCategory == MoviesCategoryKeys.topRated) {
            moreTopRatedMovies = r;
            if (moreTopRatedMovies!.moviesList.isNotEmpty) {
              topRatedMovies!
                  .loadMoreMovies(movies: moreTopRatedMovies!.moviesList);
            } else {
              hasNextPage = false;
            }
          } else if (moviesCategory == MoviesCategoryKeys.upComing) {
            moreUpComingMovies = r;
            if (moreUpComingMovies!.moviesList.isNotEmpty) {
              upComingMovies!
                  .loadMoreMovies(movies: moreUpComingMovies!.moviesList);
            } else {
              hasNextPage = false;
            }
          } else if (moviesCategory == MoviesCategoryKeys.nowPlaying) {
            moreNowPlayingMovies = r;
            if (moreNowPlayingMovies!.moviesList.isNotEmpty) {
              nowPlayingMovies!
                  .loadMoreMovies(movies: moreNowPlayingMovies!.moviesList);
            } else {
              hasNextPage = false;
            }
          } else if (moviesCategory == MoviesCategoryKeys.similarMovies) {
            moreSimilarMovies = r;
            if (moreSimilarMovies!.moviesList.isNotEmpty) {
              similarMovies!
                  .loadMoreMovies(movies: moreSimilarMovies!.moviesList);
            } else {
              hasNextPage = false;
              debugPrint('no more');
            }
          }
        });
      }).then((value) {
        emit(LoadMoreMoviesSuccessState());
      }).catchError((error) {
        debugPrint('Error from load more movies ===> ${error.toString()}');
        isLoadingMoreRunning = false;
        emit(LoadMoreMoviesErrorState());
      });
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
    movieKeywords = null;
    genresList = [];
    similarTvShows = null;
    similarMovies = null;
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
    tvKeywords = null;
    genresList = [];
    similarMovies = null;
    similarTvShows = null;
    Future.wait<void>([
      getSimilarMovies(movie: movie).then((value) {
        value.fold((l) {
          emit(GetSimilarMoviesErrorState(l.message));
        }, (r) {
          isFirstSimilarMoviesLoadingRunning = false;
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
  bool isFirstSimilarMoviesLoadingRunning = false;

  Future<Either<Failure, Movies>> getSimilarMovies(
      {required SingleMovie movie}) async {
    isFirstSimilarMoviesLoadingRunning = true;
    currentSimilarMoviesPage = 1;
    return await getSimilarMoviesUseCase.execute(
      movie: movie,
      currentSimilarMoviesPage: currentSimilarMoviesPage,
    );
  }

  int currentSimilarTVShowPage = 1;
  bool isFirstSimilarTvShowsLoadingRunning = false;

  Future<Either<Failure, Tv>> getSimilarTvShow(
      {required SingleTV tvShow}) async {
    emit(GetMovieDetailsLoadingState());
    currentSimilarTVShowPage = 1;
    isFirstSimilarTvShowsLoadingRunning = true;
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

  int currentFavoriteMoviesPage = 1;
  bool isFirstFavoriteMoviesLoadingRunning = false;

  Future<Either<Failure, Movies>> getFavoriteMovies() async {
    isFirstFavoriteMoviesLoadingRunning = true;
    return await getFavoriteMoviesUseCase.execute(
      accountId: accountDetails!.id.toString(),
      sessionId: sessionId!.sessionId,
      currentFavoriteMoviesPage: currentFavoriteMoviesPage,
    );
  }

  int currentFavoriteTvShowsPage = 1;
  bool isFirstFavoriteTvShowsLoadingRunning = false;

  Future<Either<Failure, Tv>> getFavoriteTvShows() async {
    isFirstFavoriteTvShowsLoadingRunning = true;
    return await getFavoriteTvShowsUseCase.execute(
      accountId: accountDetails!.id.toString(),
      sessionId: sessionId!.sessionId,
      currentFavoriteTvShowsPage: currentFavoriteTvShowsPage,
    );
  }

  int currentMoviesWatchListPage = 1;
  bool isFirstMoviesWatchListLoadingRunning = false;

  Future<Either<Failure, Movies>> getMoviesWatchList() async {
    isFirstMoviesWatchListLoadingRunning = true;
    return await getMoviesWatchListUseCase.execute(
      accountId: accountDetails!.id.toString(),
      sessionId: sessionId!.sessionId,
      currentMoviesWatchListPage: currentMoviesWatchListPage,
    );
  }

  int currentTvShowsWatchListPage = 1;
  bool isFirstTvShowsWatchListLoadingRunning = false;

  Future<Either<Failure, Tv>> getTvShowsWatchList() async {
    isFirstTvShowsWatchListLoadingRunning = true;
    return await getTvShowWatchListUseCase.execute(
      accountId: accountDetails!.id.toString(),
      sessionId: sessionId!.sessionId,
      currentTvShowsWatchListPage: currentTvShowsWatchListPage,
    );
  }

  // Future<void> markAsFavorite({
  //   required bool isMovie,
  //   required int mediaId,
  //   required bool favorite,
  //   bool fromFavoriteScreen = false,
  //   required BuildContext context,
  // }) async {
  //   emit(AddToFavoriteLoadingState(1));
  //   return await markAsFavoriteUseCase
  //       .execute(
  //     accountId: accountDetails!.id.toString(),
  //     sessionId: sessionId!.sessionId,
  //     mediaType: isMovie ? 'movie' : 'tv',
  //     mediaId: mediaId,
  //     favorite: favorite,
  //   )
  //       .then((value) {
  //     value.fold((l) {
  //       emit(AddToFavoriteErrorState(message: l.message));
  //     }, (r) {
  //       if (isMovie) {
  //         getFavoriteMovies().then((favoriteMoviesValue) {
  //           favoriteMoviesValue.fold((l) {
  //             emit(GetFavoriteMoviesErrorState(message: l.message));
  //           }, (r) {
  //             isFirstFavoriteMoviesLoadingRunning = false;
  //             favoriteMovies = r;
  //             Components.showSnackBar(
  //               title: AppStrings.appName,
  //               message: favorite
  //                   ? AppStrings.addedToFavorite
  //                   : AppStrings.removeFavorite,
  //               backgroundColor: AppColors.greenSuccessColor,
  //               textColor: Colors.white,
  //             );
  //             if (fromFavoriteScreen) {
  //               Components.navigateTo(
  //                   context,
  //                   const Layout(
  //                     fromFavoriteScreen: true,
  //                   ));
  //             }
  //             emit(AddToFavoriteSuccessState());
  //           });
  //         });
  //       } else {
  //         getFavoriteTvShows().then((favoriteTvShowsValue) {
  //           favoriteTvShowsValue.fold((l) {
  //             emit(GetFavoriteTvErrorState(message: l.message));
  //           }, (r) {
  //             isFirstFavoriteTvShowsLoadingRunning = false;
  //             favoriteTvShows = r;
  //             Components.showSnackBar(
  //               title: AppStrings.appName,
  //               message: favorite
  //                   ? AppStrings.addedToFavorite
  //                   : AppStrings.removeFavorite,
  //               backgroundColor: AppColors.greenSuccessColor,
  //               textColor: Colors.white,
  //             );
  //             if (fromFavoriteScreen) {
  //               Components.navigateTo(
  //                   context,
  //                   const Layout(
  //                     fromFavoriteScreen: true,
  //                   ));
  //             }
  //             emit(AddToFavoriteSuccessState());
  //           });
  //         });
  //       }
  //     });
  //   }).catchError((error) {
  //     Components.showSnackBar(
  //       title: AppStrings.appName,
  //       message: AppStrings.failFavorite,
  //       backgroundColor: AppColors.redErrorColor,
  //       textColor: AppColors.textWhiteColor,
  //     );
  //     emit(AddToFavoriteErrorState(message: error.toString()));
  //   });
  // }

  Future<void> addToWatchList({
    required int mediaId,
    required bool isMovie,
    required bool watchList,
    bool fromFavoriteScreen = false,
    required BuildContext context,
  }) async {
    emit(AddToWatchListLoadingState());
    return await addToWatchListUseCase
        .execute(
      accountId: accountDetails!.id.toString(),
      sessionId: sessionId!.sessionId,
      mediaType: isMovie ? 'movie' : 'tv',
      mediaId: mediaId,
      watchList: watchList,
    )
        .then((value) {
      value.fold((l) {
        emit(AddToWatchListErrorState(message: l.message));
      }, (r) {
        if (isMovie) {
          getMoviesWatchList().then((moviesWatchListValue) {
            moviesWatchListValue.fold((l) {
              emit(GetMoviesWatchListErrorState(message: l.message));
            }, (r) {
              isFirstMoviesWatchListLoadingRunning = false;
              moviesWatchList = r;
              Components.showSnackBar(
                title: AppStrings.appName,
                message: watchList
                    ? AppStrings.addedToWatchList
                    : AppStrings.removedFromWatchList,
                backgroundColor: AppColors.greenSuccessColor,
                textColor: Colors.white,
              );
              if (fromFavoriteScreen) {
                Components.navigateTo(
                    context,
                    const Layout(
                      fromFavoriteScreen: true,
                    ));
              }
              emit(AddToWatchListSuccessState());
            });
          });
        } else {
          getTvShowsWatchList().then((tvShowsWatchListValue) {
            tvShowsWatchListValue.fold((l) {
              emit(GetTvWatchListErrorState(message: l.message));
            }, (r) {
              isFirstTvShowsWatchListLoadingRunning = false;
              tvShowsWatchList = r;
              Components.showSnackBar(
                title: AppStrings.appName,
                message: watchList
                    ? AppStrings.addedToWatchList
                    : AppStrings.removedFromWatchList,
                backgroundColor: AppColors.greenSuccessColor,
                textColor: Colors.white,
              );
              if (fromFavoriteScreen) {
                Components.navigateTo(
                    context,
                    const Layout(
                      fromFavoriteScreen: true,
                    ));
              }
              emit(AddToWatchListSuccessState());
            });
          });
        }
      });
    });
  }
}
