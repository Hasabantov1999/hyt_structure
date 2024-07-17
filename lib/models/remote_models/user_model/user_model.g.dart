// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      sId: fields[0] as String?,
      email: fields[1] as String?,
      fcmToken: fields[2] as String?,
      name: fields[3] as String?,
      surname: fields[4] as String?,
      companyId: fields[5] as String?,
      countryCode: fields[6] as String?,
      identityNumber: fields[7] as String?,
      birthDate: fields[8] as String?,
      notifications: (fields[9] as Map?)?.cast<String, dynamic>(),
      phoneNumber: fields[10] as String?,
      createdAt: fields[11] as String?,
      hasActiveCharge: fields[12] as bool?,
      totalCharges: fields[13] as num?,
      totalEnergyConsumption: fields[14] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.fcmToken)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.surname)
      ..writeByte(5)
      ..write(obj.companyId)
      ..writeByte(6)
      ..write(obj.countryCode)
      ..writeByte(7)
      ..write(obj.identityNumber)
      ..writeByte(8)
      ..write(obj.birthDate)
      ..writeByte(9)
      ..write(obj.notifications)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.hasActiveCharge)
      ..writeByte(13)
      ..write(obj.totalCharges)
      ..writeByte(14)
      ..write(obj.totalEnergyConsumption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      sId: json['_id'] as String?,
      email: json['email'] as String?,
      fcmToken: json['fcm_token'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      companyId: json['company_id'] as String?,
      countryCode: json['country_code'] as String?,
      identityNumber: json['identity_number'] as String?,
      birthDate: json['birth_date'] as String?,
      notifications: json['notifications'] as Map<String, dynamic>?,
      phoneNumber: json['phone_number'] as String?,
      createdAt: json['created_at'] as String?,
      hasActiveCharge: json['has_active_charge'] as bool?,
      totalCharges: json['total_charges'] as num?,
      totalEnergyConsumption: json['total_energy_consumtion'] as num?,
      passwordReset: json['password_reset'] as bool?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.sId,
      'email': instance.email,
      'fcm_token': instance.fcmToken,
      'name': instance.name,
      'surname': instance.surname,
      'company_id': instance.companyId,
      'country_code': instance.countryCode,
      'identity_number': instance.identityNumber,
      'birth_date': instance.birthDate,
      'notifications': instance.notifications,
      'phone_number': instance.phoneNumber,
      'created_at': instance.createdAt,
      'has_active_charge': instance.hasActiveCharge,
      'total_charges': instance.totalCharges,
      'total_energy_consumtion': instance.totalEnergyConsumption,
      'password_reset': instance.passwordReset,
      'gender': instance.gender,
    };
