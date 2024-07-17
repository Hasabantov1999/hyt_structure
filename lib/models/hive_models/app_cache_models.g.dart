// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_cache_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppCacheModelAdapter extends TypeAdapter<AppCacheModel> {
  @override
  final int typeId = 0;

  @override
  AppCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppCacheModel()
      ..authorization = fields[0] as String?
      ..systemLocale = fields[1] as String?
      ..accessToken = fields[2] as String?
      ..refreshToken = fields[3] as String?
      ..userModel = fields[4] as UserModel?;
  }

  @override
  void write(BinaryWriter writer, AppCacheModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.authorization)
      ..writeByte(1)
      ..write(obj.systemLocale)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.userModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
