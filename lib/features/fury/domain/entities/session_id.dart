import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'session_id.g.dart';


@HiveType(typeId: 1)
class SessionId extends Equatable {
  @HiveField(0)final bool success;
  @HiveField(1)final String sessionId;

  const SessionId({required this.success, required this.sessionId});

  @override
  List<Object?> get props => [
        success,
        sessionId,
      ];
}
