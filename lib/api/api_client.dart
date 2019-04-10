import 'package:dio/dio.dart';

class ApiClient extends Dio {
  ApiClient({BaseOptions options}) : super(options) {
    interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  void setDefaultHeader(Map<String, String> headers) {
    options.headers = headers;
  }
}
