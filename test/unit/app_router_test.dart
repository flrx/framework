import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:test/test.dart';

import '../mocks/mock_route_retriever.dart';

void main() {
  group('AppRouter init test', () {
    RouteRetriever retriever = MockRouteRetriever();
    AppRouter.init(retriever);
    test('common_test', () {
      AppRouteMatch match =
          AppRouter.router.match(MockRouteRetriever.MOCK_LOGIN);
      expect(match.route.route, MockRouteRetriever.MOCK_LOGIN);
    });

    test('module_test', () {
      AppRouteMatch match =
          AppRouter.router.match(MockRouteRetriever.MOCK_CUSTOMER_HOME);
      expect(match.route.route, MockRouteRetriever.MOCK_CUSTOMER_HOME);
    });

    test('unavailable_test', () {
      AppRouteMatch match = AppRouter.router.match("/unknown");
      expect(match, null);
    });
  });
}
