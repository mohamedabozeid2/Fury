import 'package:movies_application/features/fury/domain/entities/session_id.dart';

class SessionIdModel extends SessionId {
  const SessionIdModel({
    required super.success,
    required super.sessionId,
  });

  factory SessionIdModel.fromJson(Map<String, dynamic> json) {
    return SessionIdModel(
      success: json['success'],
      sessionId: json['session_id'],
    );
  }
}
