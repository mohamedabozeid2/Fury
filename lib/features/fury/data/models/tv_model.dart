import 'package:movies_application/features/fury/data/models/single_tv.dart';
import 'package:movies_application/features/fury/domain/entities/tv.dart';

class TvModel extends Tv {
  const TvModel({
    required super.page,
    required super.tvList,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      page: json['page'],
      tvList: List<SingleTV>.from(
        json['results'].map(
          (e) => SingleTV.fromJson(e),
        ),
      ),
    );
  }
}
