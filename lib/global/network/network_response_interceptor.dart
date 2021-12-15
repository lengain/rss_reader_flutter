import 'package:dio/dio.dart';
import 'dart:convert';

/// Response 拦截器
class NetworkResponseInterceptor extends InterceptorsWrapper {
  static const String ResponseSuccess = "success";
  static const String ResponseData = "data";
  static const String ResponseMessage = "message";

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      //请求成功
      Map<String, dynamic> result;
      if (response.data is String) {
        result = jsonDecode(response.data);
      } else {
        result = response.data;
      }
      bool success = result[ResponseSuccess];
      if (success) {
        response.data = result[ResponseData];
      } else {
        response.data = DioError(
            requestOptions: response.requestOptions,
            response: response,
            type: DioErrorType.other,
            error: result[ResponseMessage]);
      }
    }
    super.onResponse(response, handler);
  }
}
