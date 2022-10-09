import 'movie_model.dart';

class PopularMoviesModel {
  num? page;
  List<MovieModel> moviesList = [];
  num? totalPages;
  num? totalResult;

  PopularMoviesModel(
      {required this.moviesList,
      required this.page,
      required this.totalResult,
      required this.totalPages});

  PopularMoviesModel.fromJson(Map<String, dynamic> json){
    page = json['page'];
    json['results'].forEach((element){
      moviesList.add(MovieModel.fromJson(element));
    });
    totalResult = json['total_results'];
    totalPages = json['total_pages'];
  }

  void loadMoreMovies({required List<MovieModel> movies}){
    print(movies.length);
    moviesList.addAll(movies);
    print('TEST =====> ${moviesList.length}');
  }
}
