abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

class MoviesGetPopularMoviesLoadingState extends MoviesStates{}
class MoviesGetPopularMoviesSuccessState extends MoviesStates{}
class MoviesGetPopularMoviesErrorState extends MoviesStates{}