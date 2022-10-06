abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

class FuryGetPopularMoviesLoadingState extends MoviesStates{}
class FuryGetPopularMoviesSuccessState extends MoviesStates{}
class FuryGetPopularMoviesErrorState extends MoviesStates{}

class FuryGetUserDataLoadingState extends MoviesStates{}
class FuryGetUserDataSuccessState extends MoviesStates{}
class FuryGetUserDataErrorState extends MoviesStates{}