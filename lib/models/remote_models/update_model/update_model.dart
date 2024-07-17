import 'package:json_annotation/json_annotation.dart';
part 'update_model.g.dart';
@JsonSerializable()
class UpdateModel {
  Version? version;
  bool? maintenance;

  UpdateModel({this.version, this.maintenance});

factory UpdateModel.fromJson(Map<String, dynamic> json) => _$UpdateModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UpdateModelToJson(this);
}
@JsonSerializable()
class Version {
  @JsonKey(name: "active_version")
  String? activeVersion;
  VersionModel? android;
  VersionModel? ios;

  Version({this.activeVersion, this.android, this.ios});
factory Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VersionToJson(this);
  
}
@JsonSerializable()
class VersionModel {
  @JsonKey(name: "min_version")
  String? minVersion;
  @JsonKey(name: "current_version")
  String? currentVersion;
  VersionModel({this.minVersion});
  factory VersionModel.fromJson(Map<String, dynamic> json) => _$VersionModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}