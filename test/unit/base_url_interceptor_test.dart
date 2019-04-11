import 'package:dio/dio.dart';
import 'package:flrx/src/api/interceptors/base_url_interceptor.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_dio_client_adapter.dart';

void main() {
  group('Base Url Interceptor', () {
    Dio dio;
    setUp(() {
      dio = new Dio();
      dio.options.baseUrl = MockAdapter.mockBase;
      dio.httpClientAdapter = MockAdapter();
      dio.interceptors.add(BaseUrlInterceptor());
    });

    test('Test Base Url is invalid', () {
      dio.options.baseUrl = "http://${MockAdapter.mockHost}";
      expect(() => dio.get("test"), throwsA(const TypeMatcher<DioError>()));
    });

    test('Test Simple Base Url with path starting with /', () async {
      //Test http://mockserver/test
      var path = "/test";
      Response response = await dio.get(path);
      expect(response.data['data']['path'], path);
      expect(response.data["errCode"], 0);

      //Test http://mockserver/test/nested
      path = "/test/nested";
      response = await dio.get(path);
      expect(response.data['data']['path'], path);
      expect(response.data["errCode"], 0);
    });

    test('Test with nested Base Url with path starting with /', () async {
      dio.options.baseUrl += "/api/";

      //Test http://mockserver/
      var path = "/";
      Response response = await dio.get(path);
      expect(response.data['data']['path'], "/");
      expect(response.data["errCode"], 0);

      //Test http://mockserver/api/
      path = "";
      response = await dio.get(path);
      expect(response.data['data']['path'], "/api/");
      expect(response.data["errCode"], 0);

      //Test http://mockserver/api/test
      path = "/test";
      response = await dio.get(path);
      expect(response.data['data']['path'], path);
      expect(response.data["errCode"], 0);
    });
  });
}
