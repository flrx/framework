import 'package:flrx/navigation/route_retriever.dart';
import 'package:flrx/navigation/router.dart';
import 'package:fluro/fluro.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_route_retriever.dart';

void main() {
  group('GenerateParamRoute function test', () {
    test('no_param_route_test', () {
      String route = "/provider";
      String paramRoute =
          AppRouter.generateParamRoute(route, <String, String>{});
      String expectedRoute = "/provider";
      expect(paramRoute, expectedRoute);
    });

    test('one_param_route_test', () {
      String route = "/provider/:providerId";
      String paramRoute = AppRouter.generateParamRoute(
          route, <String, String>{'providerId': '1'});
      String expectedRoute = "/provider/1";
      expect(paramRoute, expectedRoute);
    });

    test('multiple_param_route_test', () {
      String route = "/provider/:providerId/booking/:bookingId";
      String paramRoute = AppRouter.generateParamRoute(
          route, <String, String>{'providerId': '1', 'bookingId': '2'});
      String expectedRoute = "/provider/1/booking/2";
      expect(paramRoute, expectedRoute);
    });

    test('multiple_continuous_params_route_test', () {
      String route = "/provider/:providerId/:bookingId";
      String paramRoute = AppRouter.generateParamRoute(
          route, <String, String>{'providerId': '1', 'bookingId': '2'});
      String expectedRoute = "/provider/1/2";
      expect(paramRoute, expectedRoute);
    });

    test('single_null_param_route_test', () {
      String paramName = "providerId";
      expect(() {
        String route = "/provider/:$paramName";
        return AppRouter.generateParamRoute(
            route, <String, String>{paramName: null});
      }, throwsA(predicate((Error e) {
        return e is ArgumentError &&
            e.message == 'Param cannot be null. $paramName is passed as null';
      })));
    });

    test('single_paramname_no_param_route_test', () {
      String paramName = "providerId";
      expect(() {
        String route = "/provider/:$paramName";
        return AppRouter.generateParamRoute(route, <String, String>{});
      }, throwsA(predicate((Error e) {
        return e is ArgumentError &&
            e.message == 'Param cannot be null. $paramName is passed as null';
      })));
    });

    test('one_param_with_underscore_route_test', () {
      String route = "/provider/:provider_id";
      String paramRoute = AppRouter.generateParamRoute(
          route, <String, String>{'provider_id': '1'});
      String expectedRoute = "/provider/1";
      expect(paramRoute, expectedRoute);
    });
  });
  group('AppRouter init test', () {
    RouteRetriever retriever = MockRouteRetriever();
    AppRouter.init(retriever);
    test('common_routes_test', () {
      AppRouteMatch match =
          AppRouter.router.match(MockRouteRetriever.MOCK_LOGIN);
      expect(match.route.route, MockRouteRetriever.MOCK_LOGIN);
    });

    test('module_routes_test', () {
      AppRouteMatch match =
          AppRouter.router.match(MockRouteRetriever.MOCK_CUSTOMER_HOME);
      expect(match.route.route, MockRouteRetriever.MOCK_CUSTOMER_HOME);
    });

    test('unavailable_routes_test', () {
      AppRouteMatch match = AppRouter.router.match("/unknown");
      expect(match, null);
    });
  });
}
