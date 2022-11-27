import 'package:equatable/equatable.dart';
import 'package:movies_application/features/fury/data/models/single_movie.dart';

class Movies extends Equatable {
  final num page;
  final List<SingleMovie> moviesList;
  final num? totalPages;
  final num? totalResult;

  const Movies(
      {required this.page,
      required this.moviesList,
      required this.totalPages,
      required this.totalResult});

  @override
  // TODO: implement props
  List<Object?> get props => [
        page,
        moviesList,
        totalPages,
        totalResult,
      ];
  void loadMoreMovies({required List<SingleMovie> movies}){
    moviesList.addAll(movies);
  }
}

//
// import 'single_movie.dart';
//
// class Movies {
//   num? page;
//   List<SingleMovie> moviesList = [];
//   num? totalPages;
//   num? totalResult;
//
//   Movies(
//       {required this.moviesList,
//         required this.page,
//         required this.totalResult,
//         required this.totalPages});
//
//   Movies.fromJson(Map<String, dynamic> json){
//     page = json['page'];
//     json['results'].forEach((element){
//       moviesList.add(SingleMovie.fromJson(element));
//     });
//     totalResult = json['total_results'];
//     totalPages = json['total_pages'];
//   }
//
//   void loadMoreMovies({required List<SingleMovie> movies}){
//     moviesList.addAll(movies);
//   }
// }
