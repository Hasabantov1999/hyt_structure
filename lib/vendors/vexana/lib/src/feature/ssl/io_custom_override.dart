import 'dart:io';

import 'http_custom_override.dart';


HttpCustomOverride createAdapter() => _GeneralCustomOverride();

class _GeneralCustomOverride extends HttpCustomOverride {
  @override
  void make() {
    HttpOverrides.global = _MyHttpOverrides();
  }
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
