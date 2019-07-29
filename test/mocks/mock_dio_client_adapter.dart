import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class MockAdapter extends HttpClientAdapter {
  static const String mockHost = "mockserver";
  static const String mockBase = "http://$mockHost/";

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    Uri uri = options.uri;
    return ResponseBody.fromString(
      jsonEncode({"path": uri.path}),
      200,
      headers: DioHttpHeaders.fromMap({
        HttpHeaders.contentTypeHeader: ContentType.json,
      }),
    );
  }
}
