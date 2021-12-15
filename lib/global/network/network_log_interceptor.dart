import 'package:dio/dio.dart';
import '../global_config.dart';

/// Log拦截器
class NetworkLogInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (GlobalConfig.DEBUG) {
      print("请求URL：${options.path}");
      print("请求头：" +
          (options.headers.isEmpty ? "无" : options.headers.toString()));
      print("请求参数：" +
          (options.queryParameters.isEmpty
              ? "无"
              : options.queryParameters.toString()));
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (GlobalConfig.DEBUG) {
      print('返回数据: ' + response.toString());
    }
    super.onResponse(response, handler);
  }

  @override
  onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (GlobalConfig.DEBUG) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + err.response.toString());
    }
    super.onError(err, handler);
  }
}
