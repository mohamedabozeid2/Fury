import 'package:equatable/equatable.dart';

class FavoriteData extends Equatable {
  final int statusCode;
  final String statusMessage;

  const FavoriteData({required this.statusCode, required this.statusMessage});

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
      ];
}
