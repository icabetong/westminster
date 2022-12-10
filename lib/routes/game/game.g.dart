// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameLogAdapter extends TypeAdapter<GameLog> {
  @override
  final int typeId = 3;

  @override
  GameLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameLog(
      fields[1] as Profile,
      fields[2] as int,
      logId: fields[0] as String?,
      dateTime: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GameLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.logId)
      ..writeByte(1)
      ..write(obj.profile)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
