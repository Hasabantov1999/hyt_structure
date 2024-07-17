// ignore_for_file: avoid_relative_lib_imports

import 'package:json_annotation/json_annotation.dart';


import '../../../vendors/vexana/lib/vexana.dart';

part 'success_response_model.g.dart';

@JsonSerializable()
class SuccessModel extends INetworkModel<SuccessModel> {
  dynamic data;
  int? status;
  String? code;
  dynamic message;
  String? description;
  String? version;

  SuccessModel({
    this.data,
    this.status,
    this.code,
    this.message,
    this.description,
    this.version,
  });

    factory SuccessModel.fromJson(Map<String, dynamic> json) =>
      _$SuccessModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SuccessModelToJson(this);

  @override
  SuccessModel fromJson(Map<String, dynamic> json) {
    return SuccessModel.fromJson(json);
  }
}
