import 'package:dio/dio.dart';

typedef NetworkResultCallback = void Function(NetworkResult result);

class NetworkResult {
  bool success;
  dynamic data;
  DioError? error;
  dynamic model;

  NetworkResult(this.success,{this.data,this.error,this.model});

  @override
  String toString() {
    return super.toString() + "data:${data.toString()},error:${error.toString()}";
  }
}

abstract class NetworkResultInterceptor {
  void interceptNetworkResult(NetworkResult result,{showMessage=true});
}
