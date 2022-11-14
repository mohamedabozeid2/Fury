import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/api/movies_dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/domain/entities/genres.dart';
import 'package:movies_application/features/fury/domain/entities/single_movie.dart';
import 'package:movies_application/features/fury/presentation/screens/HomeScreen/HomeScreen.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
import '../../features/fury/domain/entities/movie_keywards.dart';
import '../../features/fury/domain/entities/movies.dart';
import '../../features/fury/domain/entities/user_data.dart';
import '../../features/fury/presentation/screens/HomeScreen/widgets/category_item_builder/category_keys.dart';
import '../../features/fury/presentation/screens/my_movies_screen/my_movies_screen.dart';
import '../../features/fury/presentation/screens/news_screen/news_screen.dart';
import '../../features/fury/presentation/screens/settings/settings_screen.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  void changBotNavBar({required int index}) {
    botNavCurrentIndex = index;
    emit(ChangeBotNavBarState());
  }

  List<Widget> screens = [
    HomeScreen(),
    MyMoviesScreen(),
    NewsScreen(),
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
      print("Error ===> ${error.toString()}");
      emit(GetUserDataErrorState());
    });
  }



  void getAllMovies({required BuildContext context}) {
    emit(GetAllMoviesLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        Future.wait([
          getPopularMovies(),
          getTrendingMovies(),
          getTopRatedMovies(),
          getUpComingMovies(),
        ]).then((value) {
          for (int i = 0; i < value.length; i++) {
            if (i == 0) {
              popularMovies = Movies.fromJson(value[i].data);
              isFirstPopularLoadRunning = false;
            } else if (i == 1) {
              trendingMovies = Movies.fromJson(value[i].data);
              isFirstTrendingLoadRunning = false;
            } else if (i == 2) {
              topRatedMovies = Movies.fromJson(value[i].data);
              isFirstTopRatedLoadRunning = false;
            } else if (i == 3) {
              upComingMovies = Movies.fromJson(value[i].data);
              isFirstUpComingLoadRunning = false;
              getMovieGenres();
            }
          }
          emit(GetAllMoviesSuccessState());
        }).catchError((error) {
          Components.navigateAndFinish(
              context: context, widget: NoInternetScreen());
          print('error ======================> ${error.toString()}');
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

  ///////////// Popular Movies ////////////
  int currentPopularPage = 1;
  bool isFirstPopularLoadRunning = false;

  Future<Response> getPopularMovies() async{
    isFirstPopularLoadRunning = true;
    return await MoviesDioHelper.getData(
        url: EndPoints.popular,
        query: {'api_key': MoviesDioHelper.apiKey, 'page': currentPopularPage});
  }

  ///////////// Top Rated Movies ////////////
  int currentTopRatedPage = 1;
  bool isFirstTopRatedLoadRunning = false;

  Future<Response> getTopRatedMovies() async{
    isFirstTopRatedLoadRunning = true;
    /////
    return await MoviesDioHelper.getData(
        url: EndPoints.topRated,
        query: {'api_key': MoviesDioHelper.apiKey, 'page': currentTrendingPage});
  }

  ///////////// Trending Movies ////////////
  int currentTrendingPage = 1;
  bool isFirstTrendingLoadRunning = false;

  Future<Response> getTrendingMovies() async{
    isFirstTrendingLoadRunning = true;
    return await MoviesDioHelper.getData(
        url: EndPoints.trending,
        query: {'api_key': MoviesDioHelper.apiKey, 'page': currentTrendingPage});
  }

  ///////////// Up Coming Movies ////////////
  int currentUpComingPage = 1;
  bool isFirstUpComingLoadRunning = false;

  Future<Response> getUpComingMovies() async{
    isFirstUpComingLoadRunning = true;
    return await MoviesDioHelper.getData(
      url: EndPoints.upComing,
      lang: 'en-US',
      query: {
        'api_key': MoviesDioHelper.apiKey,
        'page': currentUpComingPage,
        'language': 'en-US'
      },
    );
  }

//////////// Latest Movie ////////////
  Future<Response> getLatestMovie() async{
    return await MoviesDioHelper.getData(
        url: EndPoints.latest,
        query: {'api_key': MoviesDioHelper.apiKey, 'language': 'en-US'});
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
      if (moviesCategory == CategoryKeys.popular) {
        currentPopularPage++;
        endPoint = EndPoints.popular;
      } else if (moviesCategory == CategoryKeys.trending) {
        currentTrendingPage++;
        endPoint = EndPoints.trending;
      } else if (moviesCategory == CategoryKeys.topRated) {
        currentTopRatedPage++;
        endPoint = EndPoints.topRated;
      } else if (moviesCategory == CategoryKeys.upComing) {
        currentUpComingPage++;
        endPoint = EndPoints.upComing;
      } else if (moviesCategory == CategoryKeys.similarMovies) {
        currentSimilarMoviesPage++;
        endPoint = '/movie/$movieID/recommendations';
      }
      MoviesDioHelper.getData(
          url: endPoint,
          query: {'api_key': MoviesDioHelper.apiKey, 'page': page + 1}).then((value) {
        if (moviesCategory == CategoryKeys.popular) {
          morePopularMovies = Movies.fromJson(value.data);
          if (morePopularMovies!.moviesList.isNotEmpty) {
            more.addAll(morePopularMovies!.moviesList);
            popularMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.trending) {
          moreTrendingMovies = Movies.fromJson(value.data);
          if (moreTrendingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTrendingMovies!.moviesList);
            trendingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.topRated) {
          moreTopRatedMovies = Movies.fromJson(value.data);
          if (moreTopRatedMovies!.moviesList.isNotEmpty) {
            more.addAll(moreTopRatedMovies!.moviesList);
            topRatedMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.upComing) {
          moreUpComingMovies = Movies.fromJson(value.data);
          if (moreUpComingMovies!.moviesList.isNotEmpty) {
            more.addAll(moreUpComingMovies!.moviesList);
            upComingMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
          }
        } else if (moviesCategory == CategoryKeys.similarMovies) {
          moreSimilarMovies = Movies.fromJson(value.data);
          if (moreSimilarMovies!.moviesList.isNotEmpty) {
            more.addAll(moreSimilarMovies!.moviesList);
            similarMovies!.loadMoreMovies(movies: more);
          } else {
            hasNextPage = false;
            print('no more');
          }
        }
        emit(LoadMoreMoviesSuccessState());
      }).catchError((error) {
        print('Error from load more movies ===> ${error.toString()}');
        emit(LoadMoreMoviesErrorState());
      });
      isLoadingMoreRunning = false;
    }


}
  MovieKeywords? keywords;

  Future<Response> getMovieKeyword({required SingleMovie movie}) async {
    return await MoviesDioHelper.getData(
        url: '/movie/${movie.id}/keywords',
        query: {'api_key': MoviesDioHelper.apiKey});
  }
  Genres? genresModel;

  void getMovieGenres() {
    // emit(GetMovieGenresLoadingState());
    MoviesDioHelper.getData(url: EndPoints.genres, query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
    }).then((value) {
      genresModel = Genres.fromJson(value.data);
      // emit(GetMovieGenresSuccessState());
    }).catchError((error) {
      debugPrint('Error in get genres ${error.toString()}');
      emit(GetMovieDetailsErrorState());
    });
  }

  List<String> genresList = [];

  Future<void> fillGenresList({required List<int> movieGenresId}) async {
    genresList = [];
    for (int i = 0; i < genresModel!.genres.length; i++) {
      if (movieGenresId.contains(genresModel!.genres[i].id)) {
        genresList.add(genresModel!.genres[i].name!);
      }
    }
  }

  int currentSimilarMoviesPage = 1;

  // MoviesModel? similarMovies;
  void getMovieDetailsData({
    required SingleMovie movie
  }){
    Future.wait([
      getSimilarMovies(movie: movie),
      getMovieKeyword(movie: movie),

    ]).then((value){
      for(int i=0;i<value.length; i++){
        if(i==0){
          currentSimilarMoviesPage = 1;
          similarMovies = Movies.fromJson(value[i].data);
        }else if(i==1){
          keywords = MovieKeywords.fromJson(value[i].data);
        }
      }
      fillGenresList(movieGenresId: movie.genresIds).then((value){
        emit(GetMovieDetailsSuccessState());
      });
    }).catchError((error){
      debugPrint("Error in get movie details ${error.toString()}");
      emit(GetMovieDetailsErrorState());
    });
  }

  Future<Response> getSimilarMovies({required SingleMovie movie}) async {
    currentSimilarMoviesPage = 1;
    emit(GetMovieDetailsLoadingState());
    return await MoviesDioHelper.getData(url: '/movie/${movie.id}/recommendations', query: {
      'api_key': MoviesDioHelper.apiKey,
      'language': 'en-US',
      'page': currentSimilarMoviesPage,
    });
  }
}
