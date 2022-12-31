// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionIdAdapter extends TypeAdapter<SessionId> {
  @override
  final int typeId = 1;

  @override
  SessionId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionId(
      success: fields[0] as bool,
      sessionId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SessionId obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.sessionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
