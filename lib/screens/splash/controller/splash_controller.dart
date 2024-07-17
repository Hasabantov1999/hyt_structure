import 'package:fast_structure/config/app_config.dart';
import 'package:fast_structure/injection/injection.dart';
import 'package:flutter/material.dart';


import 'package:stacked/stacked.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../core/components/app_alerts.dart';
import '../../../services/hive_services/hive_services.dart';
import '../../../services/update_services/update_service.dart';
import '../../../services/vexana_services/vexana_manager.dart';

class SplashController extends BaseViewModel {
  final BuildContext context;
  SplashController({required this.context});
  void init() {
    initializeServices().then((value) {
      if (value == "unauthorized") {
        LocalCacheService.instance.model()
          ..userModel = null
          ..accessToken = null
          ..refreshToken = null
          ..save();
   
        return;
      }
      if (LocalCacheService.instance.model().userModel == null) {
   
      } else {
   
      }
    });
  }

  Future<String> initializeServices() async {
    await AppAuthService().initInstance();
    await AppBackAuthService().initInstance();
    if (LocalCacheService.instance.model().systemLocale == null) {
      LocalCacheService.instance.model()
        ..systemLocale = "tr"
        ..save();
    }
    final updateStatus = await checkUpdate();
    if (updateStatus == UpdateStatus.NeedUpdate) {
      await AppAlert.show(
        description: "Uygulamaya devam edebilmeniz için güncelleme gereklidir!",
        whenActivePressed: () async {
          await StoreRedirect.redirect(
            iOSAppId: locator.get<AppConfig>().iosId,
            androidAppId: locator.get<AppConfig>().androidId,
          );
        },
      );
      return "update";
    } else if (updateStatus == UpdateStatus.Maintenance) {
      await AppAlert.show(
        description:
            "Uygulama şuanda bakımda lütfen daha sonra tekrar deneyiniz!",
      );
    }
    if (LocalCacheService.instance.model().accessToken != null) {
      await GetUserService().request();
    }
    if (LocalCacheService.instance.model().userModel != null) {
      final result = await GetUserService().request();
      if (result != null && result is String && result == "unauthorized") {
        return "unauthorized";
      }
    }

    return "success";
  }
}
