import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  String? sId;
  @HiveField(1)
  String? email;
  @HiveField(2)
  @JsonKey(name: "fcm_token")
  String? fcmToken;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? surname;
  @HiveField(5)
  @JsonKey(name: "company_id")
  String? companyId;
  @HiveField(6)
  @JsonKey(name: "country_code")
  String? countryCode;
  @HiveField(7)
  @JsonKey(name: "identity_number")
  String? identityNumber;
  @HiveField(8)
  @JsonKey(name: "birth_date")
  String? birthDate;
  @HiveField(9)
  Map<String, dynamic>? notifications;
  @HiveField(10)
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @HiveField(11)
  @JsonKey(name: "created_at")
  String? createdAt;
  @HiveField(12)
  @JsonKey(name: "has_active_charge")
  bool? hasActiveCharge;
  @HiveField(13)
  @JsonKey(name: "total_charges")
  num? totalCharges;
  @HiveField(14)
  @JsonKey(name: "total_energy_consumtion")
  num? totalEnergyConsumption;
  @JsonKey(name: "password_reset")
  bool? passwordReset;
  String? gender;

  UserModel({
    this.sId,
    this.email,
    this.fcmToken,
    this.name,
    this.surname,
    this.companyId,
    this.countryCode,
    this.identityNumber,
    this.birthDate,
    this.notifications,
    this.phoneNumber,
    this.createdAt,
    this.hasActiveCharge,
    this.totalCharges,
    this.totalEnergyConsumption,
    this.passwordReset,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
