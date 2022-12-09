import 'package:equatable/equatable.dart';

import '../../data/models/genres_data_model.dart';

class Genres extends Equatable {
  final List<GenresData> genres;

  const Genres({required this.genres});

  @override
  // TODO: implement props
  List<Object?> get props => [genres];
}