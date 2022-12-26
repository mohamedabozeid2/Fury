// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountDetailsAdapter extends TypeAdapter<AccountDetails> {
  @override
  final int typeId = 0;

  @override
  AccountDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountDetails(
      hash: fields[0] as String,
      avatarPath: fields[1] as String,
      id: fields[2] as int,
      name: fields[3] as String,
      includeAdults: fields[4] as bool,
      userName: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hash)
      ..writeByte(1)
      ..write(obj.avatarPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.includeAdults)
      ..writeByte(5)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
