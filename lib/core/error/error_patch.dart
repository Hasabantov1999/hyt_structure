import "dart:developer" as developer;

import "package:flutter/foundation.dart";

class DeveloperErrorLog {
  static final DeveloperErrorLog instance = DeveloperErrorLog._internal();

  factory DeveloperErrorLog() => instance;

  DeveloperErrorLog._internal();
  Future<void> logService(
      Object e, StackTrace stackTrace, String pathName) async {
    _logError(e);
    _serviceRequest(e, stackTrace, pathName);
  }

  void _logError(Object msg) {
    if (kDebugMode) {
      developer.log('\x1B[31m${msg.toString()}\x1B[0m');
    }
  }

  Future<void> _serviceRequest(
      Object e, StackTrace stackTrace, String pathName) async {

  }
}
