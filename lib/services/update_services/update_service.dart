// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names, avoid_relative_lib_imports

import 'dart:io';


import 'package:fast_structure/config/app_config.dart';
import 'package:fast_structure/core/util/success_model/success_response_model.dart';
import 'package:package_info_plus/package_info_plus.dart';


import '../../injection/injection.dart';
import '../../models/remote_models/update_model/update_model.dart';
import '../../vendors/vexana/lib/vexana.dart';
import '../vexana_services/service_config.dart';

enum UpdateStatus { AlreadyUpToDate, NeedUpdate, Maintenance }

Future<UpdateStatus> checkUpdate() async {
  try {
    INetworkManager manager = NetworkManager<EmptyModel>(
      options: BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        baseUrl: locator.get<AppConfig>().devMode ? (locator.get<AppConfig>().debugAuthUrl) : (locator.get<AppConfig>().authUrl),
      ),
    );
    final result = await manager.send<SuccessModel, SuccessModel>(
      ServiceConfig.appServiceInfo,
      parseModel: SuccessModel(),
      method: RequestType.GET,
    );
    if (result.error == null &&
        result.data != null &&
        result.data!.data != null) {
      final versionModel = UpdateModel.fromJson(result.data!.data);

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (versionModel.maintenance ?? false) {
        return UpdateStatus.Maintenance;
      }
      return await _canUpdate(versionModel, packageInfo.version)
          ? UpdateStatus.NeedUpdate
          : UpdateStatus.AlreadyUpToDate;
    }
    return UpdateStatus.AlreadyUpToDate;
  } catch (e) {
    return UpdateStatus.AlreadyUpToDate;
  }
}

Future<bool> _canUpdate(UpdateModel? model, String localVersion) async {
  final _localVersion = localVersion.split('.').map(int.parse).toList();
  String _splitted = (Platform.isAndroid
          ? model?.version?.android?.minVersion
          : model?.version?.ios?.minVersion) ??
      '';

  final _minVersion = _splitted.split(".").map(int.parse).toList();
  for (var i = 0; i < _minVersion.length; i++) {
    if (_minVersion[i] > _localVersion[i]) {
      return true;
    }

    if (_localVersion[i] > _minVersion[i]) {
      return false;
    }
  }
  return false;
}
