abstract class MoviesStates {}

class MoviesInitialState extends MoviesStates {}

class ChangeBotNavBarState extends MoviesStates {}

//// Get User Data ////

class GetUserDataLoadingState extends MoviesStates {}

class GetUserDataSuccessState extends MoviesStates {}

class GetUserDataErrorState extends MoviesStates {}

//// Get Movies ////

class GetAllMoviesLoadingState extends MoviesStates {}

class GetAllMoviesSuccessState extends MoviesStates {}

class GetAllMoviesErrorState extends MoviesStates {}

class GetPopularMoviesErrorState extends MoviesStates {
  final String message;

  GetPopularMoviesErrorState({required this.message});
}

class GetTrendingMoviesErrorState extends MoviesStates {
  final String message;

  GetTrendingMoviesErrorState({required this.message});
}

class GetTopRatedMoviesErrorState extends MoviesStates {
  final String message;

  GetTopRatedMoviesErrorState({required this.message});
}

class GetUpComingMoviesErrorState extends MoviesStates {
  final String message;

  GetUpComingMoviesErrorState({required this.message});
}

class GetNowPlayingMoviesErrorState extends MoviesStates {
  final String message;

  GetNowPlayingMoviesErrorState({required this.message});
}

class GetTvAiringTodayErrorState extends MoviesStates{
  final String message;

  GetTvAiringTodayErrorState({required this.message});
}

class GetPopularTvErrorState extends MoviesStates{
  final String message;

  GetPopularTvErrorState({required this.message});
}

class GetTopRatedTvErrorState extends MoviesStates{
  final String message;

  GetTopRatedTvErrorState({required this.message});
}

class GetFavoriteTvErrorState extends MoviesStates{
  final String message;

  GetFavoriteTvErrorState({required this.message});
}
class GetTvWatchListErrorState extends MoviesStates{
  final String message;

  GetTvWatchListErrorState({required this.message});
}
class GetFavoriteMoviesErrorState extends MoviesStates{
  final String message;

  GetFavoriteMoviesErrorState({required this.message});
}

class GetMoviesWatchListErrorState extends MoviesStates{
  final String message;

  GetMoviesWatchListErrorState({required this.message});
}

class AddToFavoriteLoadingState extends MoviesStates{}
class AddToFavoriteSuccessState extends MoviesStates{}
class AddToFavoriteErrorState extends MoviesStates{
  final String message;

  AddToFavoriteErrorState({required this.message});
}

class AddToWatchListLoadingState extends MoviesStates{}
class AddToWatchListSuccessState extends MoviesStates{}
class AddToWatchListErrorState extends MoviesStates{
  final String message;
  AddToWatchListErrorState({required this.message});
}

class GetGenresErrorState extends MoviesStates {
  final String message;

  GetGenresErrorState(this.message);
}

//// pagination (Load More)
class LoadMoreMoviesLoadingState extends MoviesStates {}
class LoadMoreMoviesSuccessState extends MoviesStates {}
class LoadMoreMoviesErrorState extends MoviesStates {}

class LoadMorePopularMoviesErrorState extends MoviesStates {}

class LoadMoreTrendingMoviesErrorState extends MoviesStates {}

class LoadMoreTopRatedMoviesErrorState extends MoviesStates {}

class LoadMoreTvShowsLoadingState extends MoviesStates{}
class LoadMoreTvShowsSuccessState extends MoviesStates{}
class LoadMoreTvShowsErrorState extends MoviesStates{}

//////

////// Get movie details//////
class GetMovieDetailsLoadingState extends MoviesStates {}

class GetMovieDetailsSuccessState extends MoviesStates {}

class GetMovieDetailsErrorState extends MoviesStates {}

class GetSimilarMoviesErrorState extends MoviesStates {
  final String error;

  GetSimilarMoviesErrorState(this.error);
}

class GetMoviesKeywordsErrorState extends MoviesStates {
  final String error;

  GetMoviesKeywordsErrorState(this.error);
}

//////// Search Movies ///////
class SearchMoviesLoadingState extends MoviesStates {}

class SearchMoviesSuccessState extends MoviesStates {}

class SearchMoviesErrorState extends MoviesStates {
  final String error;

  SearchMoviesErrorState(this.error);
}
