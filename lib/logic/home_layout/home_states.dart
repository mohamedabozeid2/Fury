abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

//// Get User Data ////

class FuryGetUserDataLoadingState extends MoviesStates{}
class FuryGetUserDataSuccessState extends MoviesStates{}
class FuryGetUserDataErrorState extends MoviesStates{}

//// Get Movies ////

class FuryGetAllMoviesLoadingState extends MoviesStates{}
class FuryGetAllMoviesSuccessState extends MoviesStates{}
class FuryGetAllMoviesErrorState extends MoviesStates{}

class FuryGetPopularMoviesErrorState extends MoviesStates{}

class FuryGetTrendingMoviesErrorState extends MoviesStates{}

class FuryGetTopRatedMoviesErrorState extends MoviesStates{}


//// pagination (Load More)
class FuryLoadMoreMoviesLoadingState extends MoviesStates{}
class FuryLoadMoreMoviesSuccessState extends MoviesStates{}
class FuryLoadMoreMoviesErrorState extends MoviesStates{}

class FuryLoadMorePopularMoviesSuccessState extends MoviesStates{}
class FuryLoadMorePopularMoviesErrorState extends MoviesStates{}

class FuryLoadMoreTrendingMoviesSuccessState extends MoviesStates{}
class FuryLoadMoreTrendingMoviesErrorState extends MoviesStates{}

class FuryLoadMoreTopRatedMoviesSuccessState extends MoviesStates{}
class FuryLoadMoreTopRatedMoviesErrorState extends MoviesStates{}

//////

////// Get movie details//////
class FuryGetMovieDetailsLoadingState extends MoviesStates{}
class FuryGetMovieDetailsSuccessState extends MoviesStates{}
class FuryGetMovieDetailsErrorState extends MoviesStates{}