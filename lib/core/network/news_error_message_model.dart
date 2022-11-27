import 'package:equatable/equatable.dart';

class NewsErrorMessageModel extends Equatable {
  final String status;
  final String message;
  final String code;

  const NewsErrorMessageModel({
    required this.status,
    required this.message,
    required this.code,
  });

  factory NewsErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return NewsErrorMessageModel(
      status: json['status'],
      message: json['code'],
      code: json['message'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,
    message,
    code,
  ];
}
