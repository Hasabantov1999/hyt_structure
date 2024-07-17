// ignore_for_file: file_names

import '../../vexana.dart';

abstract class IResponseModel<T, E extends INetworkModel<E>?> {
  T data;
  IErrorModel<E>? error;
  dynamic response;
  IResponseModel(this.data, this.error, this.response);
}
