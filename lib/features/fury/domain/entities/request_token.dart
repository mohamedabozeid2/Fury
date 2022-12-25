import 'package:equatable/equatable.dart';

class RequestToken extends Equatable {
  final bool success;
  final String requestToken;

  const RequestToken({required this.success, required this.requestToken});

  @override
  List<Object?> get props => [
        success,
        requestToken,
      ];
}
