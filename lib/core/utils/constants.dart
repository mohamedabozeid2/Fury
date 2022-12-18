import 'package:movies_application/features/fury/domain/entities/movies.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';
import 'package:movies_application/features/fury/domain/entities/user_data.dart';


bool internetConnection = false;
UserData? userModel;
Movies? popularMovies;
Movies? trendingMovies;
Movies? topRatedMovies;
Movies? upComingMovies;
Movies? nowPlayingMovies;
Movies? similarMovies;
Tv? similarTvShows;
Movies? latestMovie;
Movies? moreUpComingMovies;
Movies? morePopularMovies;
Movies? moreNowPlayingMovies;
Movies? moreTopRatedMovies;
Movies? moreTrendingMovies;
Movies? moreSimilarMovies;
Tv? tvAiringToday;


dynamic uId = "";


