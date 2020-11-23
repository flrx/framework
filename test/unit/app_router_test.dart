import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

import '../mocks/mock_route_retriever.dart';

void main() {
  group('AppRouter init test', () {
    Module retriever = TestModule();
    retriever.routes().forEach(AppRouter.registerRoute);
    test('common_test', () {
      var match = AppRouter.router.match(TestModule.MOCK_LOGIN);
      expect(match.route.route, TestModule.MOCK_LOGIN);
    });

    test('module_test', () {
      var match =
          AppRouter.router.match(TestModule.MOCK_CUSTOMER_HOME);
      expect(match.route.route, TestModule.MOCK_CUSTOMER_HOME);
    });

    test('unavailable_test', () {
      var match = AppRouter.router.match('/unknown');
      expect(match, null);
    });
  });

  group('Not Found Handler', () {
    setUp(() => AppRouter.router = FluroRouter());

    test('That a not found handler can be Set', () {
      var router = AppRouter.router;
      var container = Container();

      expect(router.notFoundHandler, null);

      AppRouter.setNotFoundWidget((args) => container);

      expect(router.notFoundHandler != null, true);
      expect(router.notFoundHandler.handlerFunc(null, null), container);
    });
  });
}
