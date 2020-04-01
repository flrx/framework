import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

/// TODO(ibrahim-mubarak): We should remove dependency on Dio altogether
class MockAdapter extends DefaultHttpClientAdapter {
  static const String mockHost = "mockserver";
  static const String mockBase = "http://$mockHost/";

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    Uri uri = options.uri;
    return ResponseBody.fromString(
      jsonEncode({"path": uri.path}),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: [ContentType.json.toString()],
      },
    );
  }
}
