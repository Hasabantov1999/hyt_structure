import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

@immutable
class CustomLogger {
  CustomLogger({
    required this.data,
    this.stackTrace,
    this.isEnabled = false,
  }) {
    _printError(data);
  }
  final bool isEnabled;
  final String data;
  final StackTrace? stackTrace;
  void _printError(String data) {
    if (!isEnabled) return;
    Logger().e(
      'Error ⛔',
     data,
 stackTrace,
    );
  }
}
