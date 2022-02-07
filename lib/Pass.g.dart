// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassAdapter extends TypeAdapter<Pass> {
  @override
  final int typeId = 0;

  @override
  Pass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pass(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.remark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
