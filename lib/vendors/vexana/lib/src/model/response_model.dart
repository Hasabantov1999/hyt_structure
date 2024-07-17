
import '../../vexana.dart';

class ResponseModel<T, E extends INetworkModel<E>?>
    extends IResponseModel<T?, E> {
  ResponseModel({T? data, IErrorModel<E>? error,required dynamic response}) : super(data, error,response);
}
