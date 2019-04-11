import 'package:dio/dio.dart';

class BaseUrlInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    // Base Url is set, check base url ends with /
    var baseUrl = options.baseUrl;
    if (baseUrl != null && !baseUrl.endsWith("/")) {
      throw ArgumentError("Base Url '$baseUrl' should end with '/'");
    }
    // Base Url is set and path starts with /, Start path from domain rather than base url
    if (baseUrl != null && options.path.startsWith("/")) {
      Uri uri = Uri.parse(baseUrl).replace(path: options.path);
      options.path = uri.toString();
    }
    super.onRequest(options);
  }
}
