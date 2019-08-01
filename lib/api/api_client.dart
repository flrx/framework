import 'package:dio/dio.dart';
import 'package:flrx/src/api/interceptors/base_url_interceptor.dart';

class ApiClient extends Dio {
  ApiClient({BaseOptions options}) : super(options) {
    interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    interceptors.add(BaseUrlInterceptor());
  }

  Map<String, String> get headers => options.headers;

  set headers(Map<String, String> newHeaders) => options.headers = newHeaders;
}
