


import '../../../config/app_config.dart';
import '../../../injection/injection.dart';

class DataBaseConstants {
  static String app = locator.get<AppConfig>().appStorageBase;
  static String localizationApp = locator.get<AppConfig>().appLanguageBase;
}

class BoxConstants {
  static String app = locator.get<AppConfig>().appBox;
  static String localization = locator.get<AppConfig>().localizationBox;

}
