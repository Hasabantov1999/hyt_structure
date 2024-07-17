// ignore_for_file: file_names

import '../../vexana.dart';

abstract class IErrorModel<T extends INetworkModel?> {
  int? statusCode;
  String? description;
  T? model;
}
