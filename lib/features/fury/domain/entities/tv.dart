import 'package:equatable/equatable.dart';
import 'package:movies_application/features/fury/data/models/single_tv.dart';

class Tv extends Equatable {
  final num page;
  final List<SingleTV> tvList;
  final num? totalPages;
  final num? totalResult;

  const Tv({
    required this.page,
    required this.tvList,
    required this.totalPages,
    required this.totalResult,
  });

  @override
  List<Object?> get props => [
        page,
        tvList,
        totalResult,
        totalPages,
      ];


  void loadMoreMovies({required List<SingleTV> tv}){
    tvList.addAll(tv);
  }
}
