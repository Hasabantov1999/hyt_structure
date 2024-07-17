// ignore_for_file: avoid_relative_lib_imports

import 'package:json_annotation/json_annotation.dart';



import '../../../../vendors/vexana/lib/vexana.dart';



part "error_model.g.dart";

@JsonSerializable()
class BasicErrorModel extends INetworkModel<BasicErrorModel> {
  int? status;
  String? data;
  String? code;
  String? description;
  dynamic message;

  BasicErrorModel(
      {this.code, this.status, this.data, this.description, this.message});
  factory BasicErrorModel.fromJson(Map<String, dynamic> json) =>
      _$BasicErrorModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BasicErrorModelToJson(this);

  @override
  BasicErrorModel fromJson(Map<String, dynamic> json) {
    return BasicErrorModel.fromJson(json);
  }
}
