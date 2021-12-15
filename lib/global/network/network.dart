import 'package:dio/dio.dart';
import 'dart:collection';
import 'network_result.dart';
export 'network_result.dart';

class LNNetworkManager {

  LNNetworkManager._internal();

  static final LNNetworkManager _instance = LNNetworkManager._internal();
  factory LNNetworkManager() => _instance;

  static const ContentType = "application/json";
  static const String NetPost = "POST";
  static const String NetGet = "GET";

  var dio = Dio();
  NetworkResultInterceptor? networkResultInterceptor;

  void configNetwork(BaseOptions options,{List<Interceptor>? interceptors,NetworkResultInterceptor? networkResultInterceptor}) {
    dio = Dio(options);
    this.networkResultInterceptor = networkResultInterceptor;
    if (interceptors != null) {
      for (Interceptor warp in interceptors) {
        dio.interceptors.add(warp);
      }
    }
  }

  get(url,{data, Map<String, dynamic>? parameters, Map<String, dynamic>? header, Options? option,showMessage = true}) async {
    return request(url, NetGet,data, parameters, header, option, showMessage: showMessage);
  }

  post(url,{data, Map<String, dynamic>? parameters, Map<String, dynamic>? header, Options? option,showMessage = true}) async {
    return request(url, NetPost,data, parameters, header, option, showMessage: showMessage);
  }

  request(url,method , data, Map<String, dynamic>? parameters, Map<String, dynamic>? header, Options? option, {showMessage = true}) async {
    Map<String, dynamic> headers =  HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    if (option != null) {
      option.headers = headers;
    }else {
      option = Options(method: NetGet);
      option.headers = headers;
    }
    if (method != null) {
      option.method = method;
    }
    Response response;
    try {
      response = await dio.request(
        url,
        data:data,
        queryParameters:parameters,
        options: option,
      );
    } on DioError catch (exception) {
      return _interceptNetworkResult(
          NetworkResult(false, error: exception),
          showMessage: showMessage
      );
    }
    if (response.data is DioError) {
      return _interceptNetworkResult(
          NetworkResult(false, error: response.data),
          showMessage: showMessage
      );
    }
    return _interceptNetworkResult(
        NetworkResult(true, data: response.data),
        showMessage: showMessage
    );
  }

  NetworkResult _interceptNetworkResult(NetworkResult networkResult,{showMessage = true}) {
    if (networkResultInterceptor is NetworkResultInterceptor) {
      networkResultInterceptor!.interceptNetworkResult(networkResult,showMessage: showMessage);
    }
    return networkResult;
  }
}
