import 'package:fast_structure/models/remote_models/user_model/user_model.dart';
import 'package:hive/hive.dart';

part "app_cache_models.g.dart";

@HiveType(typeId: 0)
class AppCacheModel extends HiveObject {
  @HiveField(0)
  String? authorization;


  @HiveField(1)
  String? systemLocale;
  @HiveField(2)
  String? accessToken;
  @HiveField(3)
  String? refreshToken;
  @HiveField(4)
  UserModel? userModel;
}
