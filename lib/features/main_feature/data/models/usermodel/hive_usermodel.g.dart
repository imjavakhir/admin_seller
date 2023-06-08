// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelHiveAdapter extends TypeAdapter<UserModelHive> {
  @override
  final int typeId = 0;

  @override
  UserModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelHive()
      ..fullName = fields[0] as String
      ..type = fields[1] as String
      ..branch = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, UserModelHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.branch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
