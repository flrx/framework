import 'dart:async';

import 'package:dio/dio.dart';

/// TODO(ibrahim-mubarak): We should maybe submit this to dio
class BaseUrlInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    // Base Url is set, check base url ends with /
    var baseUrl = options.baseUrl;

    // Base URL is null, Continue as is
    if (baseUrl == null) {
      return options;
    }

    // If Base Url doesn't have a trailing slash, we can't set relative URLs,
    if (!baseUrl.endsWith("/")) {
      throw ArgumentError("Base Url '$baseUrl' should end with '/'");
    }

    // Path starts with '/', Start path from domain rather than base url
    if (options.path.startsWith("/")) {
      Uri uri = Uri.parse(baseUrl).replace(path: options.path);
      options.path = uri.toString();
    }

    return options;
  }
}
