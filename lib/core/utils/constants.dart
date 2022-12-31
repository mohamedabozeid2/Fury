import 'dart:io';

import 'package:movies_application/features/fury/domain/entities/account_details.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';

import '../../features/fury/domain/entities/session_id.dart';

AccountDetails? accountDetails;
SessionId? sessionId;
bool internetConnection = false;
Directory? directory;
Movies? popularMovies;
Movies? trendingMovies;
Movies? topRatedMovies;
Movies? upComingMovies;
Movies? nowPlayingMovies;
Movies? similarMovies;
Movies? latestMovie;
Movies? favoriteMovies;
Movies? moviesWatchList;
Movies? moreUpComingMovies;
Movies? morePopularMovies;
Movies? moreNowPlayingMovies;
Movies? moreTopRatedMovies;
Movies? moreTrendingMovies;
Movies? moreSimilarMovies;
Movies? moreFavoriteMovies;
Movies? moreMoviesWatchList;
Tv? tvAiringToday;
Tv? popularTv;
Tv? topRatedTv;
Tv? moreTvAiringToday;
Tv? morePopularTv;
Tv? moreTopRatedTv;
Tv? similarTvShows;
Tv? moreSimilarTvShows;
Tv? favoriteTvShows;
Tv? tvShowsWatchList;
Tv? moreFavoriteTvShows;
Tv? moreTvShowsWatchList;



dynamic uId = "";


