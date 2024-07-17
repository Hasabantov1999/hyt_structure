import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive_models/app_cache_models.dart';
import 'model/cache_key_model.dart';

class LocalCacheService {
  static LocalCacheService? _instance;

  static LocalCacheService get instance => _instance ??= LocalCacheService._init();

  LocalCacheService._init();

  Box<AppCacheModel?>? _box;
  Box<String?>? _rememberMeBox;

  Box<AppCacheModel?> get getBox => _box!;

  Box<String?>? get getRememberMeBox => _rememberMeBox!;

  AppCacheModel model() {
    if (_box?.get(BoxConstants.app) == null) {
      initInstance().then((value) {
        return _box!.get(BoxConstants.app)!;
      });
    }
    return _box!.get(BoxConstants.app)!;
  }

  Future<void> setModel(AppCacheModel appCacheModel) async {
    _box!.put(BoxConstants.app, appCacheModel);
  }



  Future<void> initInstance() async {
    _box = await Hive.openBox<AppCacheModel?>(DataBaseConstants.app);


    if (_box!.get(BoxConstants.app) == null) {
      await _box!.put(
        BoxConstants.app,
        AppCacheModel(),
      );
    }
  }
}
