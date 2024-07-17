import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

@immutable

/// This class will help json encode operation with safety

@immutable
class JsonDecodeUtil {
  const JsonDecodeUtil._();

  /// Decode your [jsonString] value or null
  static dynamic safeJsonDecode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e, stackTrace) {
      Logger().e(jsonString);
      Logger().e(
        'JSON Decode Error ⛔',
        'There was a problem during the JSON decoding process.',
        stackTrace,
      );
      return null;
    }
  }

  /// Decode your [jsonString] value or null
  static Future<dynamic> safeJsonDecodeCompute(String jsonString) async {
    try {
      return await compute<String, dynamic>(
        jsonDecode,
        jsonString,
      );
    } catch (e) {
      Logger().e('JSON Decode Error ⛔',
          'There was a problem during the JSON decoding process.');
      return null;
    }
  }
}
