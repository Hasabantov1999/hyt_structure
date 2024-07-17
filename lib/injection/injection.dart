// ignore_for_file: non_constant_identifier_names

import 'package:fast_structure/config/app_config.dart';
import 'package:get_it/get_it.dart';

import '../app/services/app_stater_services.dart';

final locator = GetIt.instance;

Future<void> setupInjection() async {
  locator.registerSingleton<AppSetup>(
    AppSetup(),
  );
}
