// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheContentAdapter extends TypeAdapter<CacheContent> {
  @override
  final int typeId = 1;

  @override
  CacheContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheContent(
      id: fields[0] as int,
      data: (fields[1] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CacheContent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
