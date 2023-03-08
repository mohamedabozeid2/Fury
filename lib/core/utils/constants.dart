import 'dart:io';

import 'package:flutter_zoom_drawer/config.dart';
import 'package:movies_application/features/fury/domain/entities/account_details.dart';
import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';

import '../../features/fury/domain/entities/session_id.dart';

final drawerController = ZoomDrawerController();
AccountDetails? accountDetails;
SessionId? sessionId;
bool internetConnection = false;
Directory? directory;
Movies? popularMovies;
Movies? trendingMovies;
Movies? topRatedMovies;
Movies? upComingMovies;
Movies? nowPlayingMovies;
Movies? latestMovie;
// Movies? favoriteMovies;
Movies? moviesWatchList;
Movies? moreUpComingMovies;
Movies? morePopularMovies;
Movies? moreNowPlayingMovies;
Movies? moreTopRatedMovies;
Movies? moreTrendingMovies;
// Movies? moreFavoriteMovies;
Movies? moreMoviesWatchList;
Tv? tvAiringToday;
Tv? popularTv;
Tv? topRatedTv;
Tv? moreTvAiringToday;
Tv? morePopularTv;
Tv? moreTopRatedTv;

// Tv? favoriteTvShows;
Tv? tvShowsWatchList;
// Tv? moreFavoriteTvShows;
Tv? moreTvShowsWatchList;
List<dynamic> watchListData = [];


dynamic uId = "";


