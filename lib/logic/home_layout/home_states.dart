abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

class ChangeBotNavBarState extends MoviesStates{}

//// Get User Data ////

class GetUserDataLoadingState extends MoviesStates{}
class GetUserDataSuccessState extends MoviesStates{}
class GetUserDataErrorState extends MoviesStates{}

//// Get Movies ////

class GetAllMoviesLoadingState extends MoviesStates{}
class GetAllMoviesSuccessState extends MoviesStates{}
class GetAllMoviesErrorState extends MoviesStates{}

class GetPopularMoviesErrorState extends MoviesStates{}

class GetTrendingMoviesErrorState extends MoviesStates{}

class GetTopRatedMoviesErrorState extends MoviesStates{}


//// pagination (Load More)
class LoadMoreMoviesLoadingState extends MoviesStates{}
class LoadMoreMoviesSuccessState extends MoviesStates{}
class LoadMoreMoviesErrorState extends MoviesStates{}

class LoadMorePopularMoviesSuccessState extends MoviesStates{}
class LoadMorePopularMoviesErrorState extends MoviesStates{}

class LoadMoreTrendingMoviesSuccessState extends MoviesStates{}
class LoadMoreTrendingMoviesErrorState extends MoviesStates{}

class LoadMoreTopRatedMoviesSuccessState extends MoviesStates{}
class LoadMoreTopRatedMoviesErrorState extends MoviesStates{}

//////

////// Get movie details//////
class GetMovieDetailsLoadingState extends MoviesStates{}
class GetMovieDetailsSuccessState extends MoviesStates{}
class GetMovieDetailsErrorState extends MoviesStates{}