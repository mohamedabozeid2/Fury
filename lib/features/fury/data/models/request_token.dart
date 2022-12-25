import 'package:movies_application/features/fury/domain/entities/request_token.dart';

class RequestTokenModel extends RequestToken {
  const RequestTokenModel({
    required super.success,
    required super.requestToken,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      success: json['success'],
      requestToken: json['request_token'],
    );
  }
}
