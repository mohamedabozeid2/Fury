import 'package:flutter/material.dart';

import 'movie_model.dart';

class MoviesModel {
  num? page;
  List<MovieModel> moviesList = [];
  num? totalPages;
  num? totalResult;

  MoviesModel(
      {required this.moviesList,
      required this.page,
      required this.totalResult,
      required this.totalPages});

  MoviesModel.fromJson(Map<String, dynamic> json){
    page = json['page'];
    json['results'].forEach((element){
      moviesList.add(MovieModel.fromJson(element));
    });
    totalResult = json['total_results'];
    totalPages = json['total_pages'];
  }

  void loadMoreMovies({required List<MovieModel> movies}){
    debugPrint('${movies.length}');
    moviesList.addAll(movies);
    debugPrint('TEST =====> ${moviesList.length}');
  }
}
