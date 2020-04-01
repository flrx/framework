import 'package:dio/dio.dart';
import 'package:flrx/src/api/interceptors/base_url_interceptor.dart';

/// TODO(ibrahim-mubarak): We should remove dependency on Dio altogether
abstract class ApiClient extends Dio {
  factory ApiClient({BaseOptions options}) {
    var dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors.add(BaseUrlInterceptor());
    return dio;
  }

  Map<String, String> get headers => options.headers;

  set headers(Map<String, String> newHeaders) => options.headers = newHeaders;
}
