import 'package:equatable/equatable.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';

class Tv extends Equatable {
  final num page;
  final List<SingleTV> tvList;
  final bool isMovie = false;

  const Tv({
    required this.page,
    required this.tvList,
  });

  @override
  List<Object?> get props => [
        page,
        tvList,
      ];

  void loadMoreMovies({required List<SingleTV> tv}) {
    tvList.addAll(tv);
  }
}
