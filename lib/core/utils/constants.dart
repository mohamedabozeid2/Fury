import 'dart:io';

import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/entities/user_data.dart';


bool internetConnection = false;
Directory? directory;
UserData? userModel;
Movies? popularMovies;
Movies? trendingMovies;
Movies? topRatedMovies;
Movies? upComingMovies;
Movies? nowPlayingMovies;
Movies? similarMovies;
Movies? latestMovie;
Movies? moreUpComingMovies;
Movies? morePopularMovies;
Movies? moreNowPlayingMovies;
Movies? moreTopRatedMovies;
Movies? moreTrendingMovies;
Movies? moreSimilarMovies;
Tv? tvAiringToday;
Tv? popularTv;
Tv? topRatedTv;
Tv? moreTvAiringToday;
Tv? morePopularTv;
Tv? moreTopRatedTv;
Tv? similarTvShows;
Tv? moreSimilarTvShows;



dynamic uId = "";


