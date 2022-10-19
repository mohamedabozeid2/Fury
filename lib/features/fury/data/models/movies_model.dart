import 'package:flutter/material.dart';

import 'single_movie_model.dart';

class MoviesModel {
  num? page;
  List<SingleMovieModel> moviesList = [];
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
      moviesList.add(SingleMovieModel.fromJson(element));
    });
    totalResult = json['total_results'];
    totalPages = json['total_pages'];
  }

  void loadMoreMovies({required List<SingleMovieModel> movies}){
    moviesList.addAll(movies);
  }
}
