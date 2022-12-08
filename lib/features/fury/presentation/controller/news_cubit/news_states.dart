abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class GetNewsLoadingState extends NewsStates {}

class GetNewsSuccessState extends NewsStates {}

class GetMoviesNewsErrorState extends NewsStates {
  final String error;

  GetMoviesNewsErrorState({required this.error});
}

class GetBusinessNewsErrorState extends NewsStates {
  final String error;

  GetBusinessNewsErrorState({required this.error});
}

class GetGeneralNewsErrorState extends NewsStates {
  final String error;

  GetGeneralNewsErrorState({required this.error});
}

class GetHealthNewsErrorState extends NewsStates {
  final String error;

  GetHealthNewsErrorState({required this.error});
}

class GetScienceNewsErrorState extends NewsStates {
  final String error;

  GetScienceNewsErrorState({required this.error});
}

class GetSportsNewsErrorState extends NewsStates {
  final String error;

  GetSportsNewsErrorState({required this.error});
}

class GetTechnologyNewsErrorState extends NewsStates {
  final String error;

  GetTechnologyNewsErrorState({required this.error});
}

class LoadMoreNewsLoadingState extends NewsStates {}
class LoadMoreNewsSuccessState extends NewsStates {}
class LoadMoreNewsErrorState extends NewsStates {
  final String error;

  LoadMoreNewsErrorState({required this.error});
}
