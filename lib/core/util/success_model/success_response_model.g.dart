// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessModel _$SuccessModelFromJson(Map<String, dynamic> json) => SuccessModel(
      data: json['data'],
      status: json['status'] as int?,
      code: json['code'] as String?,
      message: json['message'],
      description: json['description'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$SuccessModelToJson(SuccessModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'description': instance.description,
      'version': instance.version,
    };
