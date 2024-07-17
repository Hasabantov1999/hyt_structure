// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateModel _$UpdateModelFromJson(Map<String, dynamic> json) => UpdateModel(
      version: json['version'] == null
          ? null
          : Version.fromJson(json['version'] as Map<String, dynamic>),
      maintenance: json['maintenance'] as bool?,
    );

Map<String, dynamic> _$UpdateModelToJson(UpdateModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'maintenance': instance.maintenance,
    };

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      activeVersion: json['active_version'] as String?,
      android: json['android'] == null
          ? null
          : VersionModel.fromJson(json['android'] as Map<String, dynamic>),
      ios: json['ios'] == null
          ? null
          : VersionModel.fromJson(json['ios'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'active_version': instance.activeVersion,
      'android': instance.android,
      'ios': instance.ios,
    };

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      minVersion: json['min_version'] as String?,
    )..currentVersion = json['current_version'] as String?;

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'min_version': instance.minVersion,
      'current_version': instance.currentVersion,
    };
