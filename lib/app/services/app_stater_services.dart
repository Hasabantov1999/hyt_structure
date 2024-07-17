// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'dart:io';

import 'package:fast_structure/config/app_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as Env;
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';

import '../../core/error/error_patch.dart';
import '../../core/util/developer_log.dart';
import '../../injection/injection.dart';
import '../../models/hive_models/app_cache_models.dart';
import '../../models/remote_models/user_model/user_model.dart';
import '../../services/hive_services/hive_services.dart';
import '../../services/localization_services/localization_model.dart';
import '../../services/localization_services/localization_services.dart';

class AppSetup {
  Future<void> envSetup() async {
    try {
      await Env.dotenv.load();
      DeveloperLog.instance.logSuccess("Env File Load Succesfully");
    } catch (e, stackTrace) {
      DeveloperErrorLog.instance.logService(e, stackTrace, "/envLoadPath");
    }
  }

  void setupOriantations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    DeveloperLog.instance.logInfo(
      {
        "DeviceOrientations": [
          "DeviceOrientation.portraitUp",
          "DeviceOrientation.portraitDown",
        ]
      },
    );
  }

  Future<void> loadHiveAdapters() async {
    Hive.registerAdapter(AppCacheModelAdapter());
    Hive.registerAdapter(LocalizationModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    DeveloperLog.instance.logSuccess(
      "Hive adapters registered succesfully",
    );
  }

  Future<void> loadHive() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();

      String appDocPath = appDocDir.path;

      await Hive.initFlutter(appDocPath);
      await loadHiveAdapters();
      await LocalCacheService.instance.initInstance();
      await LocalizationCacheService.instance.initInstance();
      DeveloperLog.instance.logSuccess("Hive Init Succesfully");
    } catch (e, stackTrace) {
      DeveloperErrorLog.instance
          .logService(e, stackTrace, "/hive-initalization");
    }
  }

  void registerConfig() {
    locator.registerSingleton<AppConfig>(
      AppConfig(),
    );
  }
}
