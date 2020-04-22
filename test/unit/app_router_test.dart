import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
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

  group("Not Found Handler", () {
    setUp(() => AppRouter.router = Router());

    test("That a not found handler can be Set", () {
      Router router = AppRouter.router;
      Container container = Container();

      expect(router.notFoundHandler, null);

      AppRouter.setNotFoundWidget((args) => container);

      expect(router.notFoundHandler != null, true);
      expect(router.notFoundHandler.handlerFunc(null, null), container);
    });
  });
}
