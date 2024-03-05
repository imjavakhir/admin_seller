// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_client_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveClientModelAdapter extends TypeAdapter<HiveClientModel> {
  @override
  final int typeId = 1;

  @override
  HiveClientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveClientModel()
      ..fullName = fields[0] as String
      ..phoneNumber = fields[1] as String
      ..whereFrom = fields[2] as String
      ..details = fields[3] as String
      ..id = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, HiveClientModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.whereFrom)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveClientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
