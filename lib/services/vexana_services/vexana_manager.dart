// ignore_for_file: avoid_relative_lib_imports

import 'dart:io';

import 'package:fast_structure/config/app_config.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../core/components/app_alerts.dart';
import '../../core/error/network_error_model/model/error_model.dart';
import '../../core/util/developer_log.dart';
import '../../core/util/success_model/success_response_model.dart';
import '../../injection/injection.dart';
import '../../models/remote_models/user_model/user_model.dart';
import '../../vendors/vexana/lib/vexana.dart';
import '../hive_services/hive_services.dart';
import '../language_services/language_services.dart';
import 'service_config.dart';



class AppAuthService {
  static final AppAuthService _singleton = AppAuthService._internal();

  factory AppAuthService() {
    return _singleton;
  }
  late INetworkManager _manager;
  AppAuthService._internal();
  INetworkManager get manager => _manager;
  Future<void> initInstance({String? refreshToken, String? acceptToken}) async {
    if (refreshToken != null && acceptToken != null) {
      LocalCacheService.instance.model()
        ..accessToken = acceptToken
        ..refreshToken = refreshToken
        ..save();
    }
    _manager = NetworkManager<BasicErrorModel>(
      options: BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        baseUrl: locator.get<AppConfig>().devMode ? (locator.get<AppConfig>().debugAuthUrl) : (locator.get<AppConfig>().authUrl),
      ),
      isEnableLogger: true,
      errorModel: BasicErrorModel(),
      onRefreshFail: () {
        DeveloperLog.instance.logError("Api Error");
      },
      onRefreshToken: (error, newService) async {
        newService.addBaseHeader(
          MapEntry(
            "Authorization",
            "Bearer ${GetToken().refreshToken}",
          ),
        );
        final refreshToken = await newService.send<SuccessModel, SuccessModel>(
          ServiceConfig.loginPath,
          parseModel: SuccessModel(),
          method: RequestType.PUT,
        );
        if (refreshToken.error == null) {
          if (refreshToken.data?.data is Map<String, dynamic>) {
            LocalCacheService.instance.model()
              ..accessToken = refreshToken.data?.data['access_token']
              ..save();
            await GetUserService().request(refresh: false);
            error.requestOptions.headers = {
              HttpHeaders.authorizationHeader:
                  "Bearer ${refreshToken.data?.data['access_token']}"
            };
          }
        }
        return error;
      },
      errorModelFromData: (data, statusCode) {
        if (data["status"] == 401) {
          return BasicErrorModel.fromJson(data);
        }
        DeveloperLog.instance.logError(data.toString());
        String detailDescription = "";
        if (data['message'] != null) {
          if (data['message'] is Map<String, dynamic>) {
            data['message'].forEach((key, value) {
              detailDescription += key.toString() + value[0].toString();
            });
          } else {
            if (data["message"] is String) {
              detailDescription = data['message'];
            }
          }
        }
        LanguageService.translate(detailDescription).then(
          (translate) {
            AppAlert.show(description: translate);
          },
        );
        return BasicErrorModel.fromJson(data);
      },
      noNetwork: NoNetwork(
        navigatorKey.currentState!.context,
        customNoNetwork: (onRetry) {
          DeveloperLog.instance.logError("Api Error");
          AppAlert.show(description: "İnternet Bağlantınız Bulunmamaktadır");
        },
      ),
    );
  }
}

class AppBackAuthService {
  static final AppBackAuthService _singleton = AppBackAuthService._internal();

  factory AppBackAuthService() {
    return _singleton;
  }
  late INetworkManager _manager;
  AppBackAuthService._internal();
  INetworkManager get manager => _manager;
  Future<void> initInstance({String? refreshToken, String? acceptToken}) async {
    if (refreshToken != null && acceptToken != null) {
      LocalCacheService.instance.model()
        ..accessToken = acceptToken
        ..refreshToken = refreshToken
        ..save();
    }
    _manager = NetworkManager<BasicErrorModel>(
      options: BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        baseUrl: locator.get<AppConfig>().devMode
            ? (locator.get<AppConfig>().debugBackOfficeUrl)
            : (locator.get<AppConfig>().backOfficeUrl),
      ),
      isEnableLogger: true,
      errorModel: BasicErrorModel(),
      onRefreshToken: (error, newService) async {
        newService.addBaseHeader(
          MapEntry(
            "Authorization",
            "Bearer ${GetToken().refreshToken}",
          ),
        );
        final refreshToken = await newService.send<SuccessModel, SuccessModel>(
          ServiceConfig.loginPath,
          parseModel: SuccessModel(),
          method: RequestType.PUT,
        );
        if (refreshToken.error == null) {
          if (refreshToken.data?.data is Map<String, dynamic>) {
            LocalCacheService.instance.model()
              ..accessToken = refreshToken.data?.data['access_token']
              ..save();
            await GetUserService().request(refresh: false);
            error.requestOptions.headers = {
              HttpHeaders.authorizationHeader:
                  "Bearer ${refreshToken.data?.data['access_token']}"
            };
          }
        }
        return error;
      },
      errorModelFromData: (data, statusCode) {
        if (data["status"] == 401) {
          return BasicErrorModel.fromJson(data);
        }
        if (data['code'] == "not_found") {
          return BasicErrorModel.fromJson(data);
        }
        String detailDescription = "";
        if (data['message'] != null) {
          if (data['message'] is Map<String, dynamic>) {
            data['message'].forEach((key, value) {
              detailDescription += key.toString() + value[0].toString();
            });
          } else {
            if (data["message"] is String) {
              detailDescription = data['message'];
            }
          }
        }

        LanguageService.translate(detailDescription).then(
          (translate) {
            AppAlert.show(description: translate);
          },
        );
        DeveloperLog.instance.logError(data.toString());
        return BasicErrorModel.fromJson(data);
      },
      noNetwork: NoNetwork(
        navigatorKey.currentState!.context,
        customNoNetwork: (onRetry) {
          DeveloperLog.instance.logError("Api Error");
          AppAlert.show(description: "İnternet Bağlantınız Bulunmamaktadır");
        },
      ),
    );
  }
}

class GetToken {
  static final GetToken _singleton = GetToken._internal();

  factory GetToken() {
    return _singleton;
  }
  GetToken._internal();

  String get token => LocalCacheService.instance.model().accessToken ?? "";
  String get refreshToken =>
      LocalCacheService.instance.model().refreshToken ?? "";
}

class GetUserService {
  static final GetUserService _singleton = GetUserService._internal();

  factory GetUserService() {
    return _singleton;
  }
  GetUserService._internal();

  Future request({bool refresh = true}) async {
    AppAuthService().manager.addBaseHeader(
          MapEntry(
            "Authorization",
            "Bearer ${GetToken().token}",
          ),
        );
    AppBackAuthService().manager.addBaseHeader(
          MapEntry(
            "Authorization",
            "Bearer ${GetToken().token}",
          ),
        );
    if (refresh) {
      final result =
          await AppAuthService().manager.send<SuccessModel, SuccessModel>(
                ServiceConfig.getMe,
                parseModel: SuccessModel(),
                method: RequestType.GET,
              );

      if (result.error == null) {
        LocalCacheService.instance.model()
          ..userModel = UserModel.fromJson(result.data?.data)
          ..save();
      } else {
        if (result.error?.statusCode == 401) {
          return "unauthorized";
        }
      }
    }
  }
}
