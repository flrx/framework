import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:test/test.dart';

import '../mocks/mock_module.dart';

void main() {
  group('AppRouter init test', () {
    Module module = MockModule();
    module.routes().forEach(AppRouter.registerRoute);

    test('module_test', () {
      var match = AppRouter.router.match(MockModule.HOME);
      expect(match.route.route, MockModule.HOME);
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
