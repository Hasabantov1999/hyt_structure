// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicErrorModel _$BasicErrorModelFromJson(Map<String, dynamic> json) =>
    BasicErrorModel(
      code: json['code'] as String?,
      status: json['status'] as int?,
      data: json['data'] as String?,
      description: json['description'] as String?,
      message: json['message'],
    );

Map<String, dynamic> _$BasicErrorModelToJson(BasicErrorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'code': instance.code,
      'description': instance.description,
      'message': instance.message,
    };
