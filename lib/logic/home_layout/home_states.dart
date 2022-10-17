abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

class FuryGetAllMoviesLoadingState extends MoviesStates{}
class FuryGetAllMoviesSuccessState extends MoviesStates{}
class FuryGetAllMoviesErrorState extends MoviesStates{}

class FuryGetPopularMoviesLoadingState extends MoviesStates{}
class FuryGetPopularMoviesSuccessState extends MoviesStates{}
class FuryGetPopularMoviesErrorState extends MoviesStates{}

class FuryGetTrendingMoviesLoadingState extends MoviesStates{}
class FuryGetTrendingMoviesSuccessState extends MoviesStates{}
class FuryGetTrendingMoviesErrorState extends MoviesStates{}

class FuryLoadMorePopularMoviesLoadingState extends MoviesStates{}
class FuryLoadMorePopularMoviesSuccessState extends MoviesStates{}
class FuryLoadMorePopularMoviesErrorState extends MoviesStates{}

class FuryLoadMoreTrendingMoviesLoadingState extends MoviesStates{}
class FuryLoadMoreTrendingMoviesSuccessState extends MoviesStates{}
class FuryLoadMoreTrendingMoviesErrorState extends MoviesStates{}

class FuryGetUserDataLoadingState extends MoviesStates{}
class FuryGetUserDataSuccessState extends MoviesStates{}
class FuryGetUserDataErrorState extends MoviesStates{}