import 'package:movies_application/features/fury/domain/entities/favorite_data.dart';

class FavoriteDataModel extends FavoriteData {
  const FavoriteDataModel({
    required super.statusCode,
    required super.statusMessage,
  });

  factory FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDataModel(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
    );
  }
}
