import 'package:equatable/equatable.dart';

class MoviesErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;

  const MoviesErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  factory MoviesErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return MoviesErrorMessageModel(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      success: json['success'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        statusCode,
        statusMessage,
        success,
      ];
}
