import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';
import 'app/services/app_stater_services.dart';
import 'core/components/app_button_icon.dart';
import 'core/error/error_patch.dart';
import 'core/util/city_state_service.dart';
import 'injection/injection.dart';
import 'services/firebase_notifications_service/firebase_notification_service.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupInjection();
      locator.get<AppSetup>().setupOriantations();
      await locator.get<AppSetup>().envSetup();
      await locator.get<AppSetup>().loadHive();
      locator.get<AppSetup>().registerConfig();

      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      //   name: Platform.isIOS ? "DentalCare_Ios_InterFace" : null,
      // );

      await FirebaseNotificationService().connectNotification();
      NlAsenkronButtonManager().crasher = (e, stackTrace) {
        DeveloperErrorLog.instance.logService(e, stackTrace, "buttonErrors");
        return Future.error(e);
      };
      await CodeFinderService.instance.loadCountryData();

      await SentryFlutter.init(
        (options) {
          options.dsn = dotenv.env["SENTRY_DSN"];
        },
      );
      runApp(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: const App(),
        ),
      );
    },
    (error, stack) async {
      DeveloperErrorLog.instance.logService(error, stack, "RunZonedGuard");
      await Sentry.captureException(error, stackTrace: stack);
    },
  );
}
