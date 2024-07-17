import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  String envAssetPath = '.env';
  String appStorageBase = 'DATABASE';
  String appLanguageBase = 'localDatabase';
  String debugAuthUrl = dotenv.env['DEBUG_AUTH_URL'] ?? "";
  String debugBackOfficeUrl = dotenv.env['DEBUG_BACK_OFFICE'] ?? "";
  String authUrl = dotenv.env['AUTH_URL'] ?? "";
  String backOfficeUrl = dotenv.env['BACK_OFFICE'] ?? "";
  String appBox = "appBox";
  String localizationBox = "localBox";
  bool devMode = dotenv.env['DEV_MODE'] == "true" ? true : false;
  String iosId = dotenv.env['IOS_ID'] ?? "";
  String androidId = dotenv.env['ANDROID_ID'] ?? "";
  Size get appFigmaSize => Size(double.parse(dotenv.env["FIGMA_WIDTH"] ?? "0"),
      double.parse(dotenv.env["FIGMA_HEIGHT"] ?? "0"));
}
