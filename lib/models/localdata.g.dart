// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaldataAdapter extends TypeAdapter<Localdata> {
  @override
  final int typeId = 0;

  @override
  Localdata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Localdata(
      uuid: fields[0] == null ? '' : fields[0] as String,
      name: fields[1] == null ? '' : fields[1] as String,
    )
      ..thumbUp = fields[2] == null ? [] : (fields[2] as List).cast<String>()
      ..thumbDown = fields[3] == null ? [] : (fields[3] as List).cast<String>()
      ..commentBlock =
          fields[4] == null ? [] : (fields[4] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, Localdata obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbUp)
      ..writeByte(3)
      ..write(obj.thumbDown)
      ..writeByte(4)
      ..write(obj.commentBlock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaldataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
