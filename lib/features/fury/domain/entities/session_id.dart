import 'package:equatable/equatable.dart';

class SessionId extends Equatable {
  final bool success;
  final String sessionId;

  const SessionId({required this.success, required this.sessionId});

  @override
  List<Object?> get props => [
        success,
        sessionId,
      ];
}
