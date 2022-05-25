import 'package:flrx/components/modules/module.dart';
import 'package:test/test.dart';

import '../mocks/mock_module.dart';

void main() {
  group('AppRouter init test', () {
    Module module = MockModule();
    // module.routes().forEach(AppRouter.registerRoute);

    test('module_test', () {
      // var match = AppRouter.router.match(MockModule.home);
      // expect(match?.route.route, MockModule.home);
    });

    test('unavailable_test', () {
      // var match = AppRouter.router.match('/unknown');
      // expect(match, null);
    });
  });

  group('Not Found Handler', () {
    // setUp(() => AppRouter.router = FluroRouter());

    test('That a not found handler can be Set', () {
      // var router = AppRouter.goRouter;
      // var container = Container();

      // expect(router.routerDelegate.errorBuilder, null);

      // AppRouter.setNotFoundWidget((args) => container);

      // expect(router.routerDelegate.errorBuilder != null, true);
      // expect(router.routerDelegate.errorBuilder!(null, {}), container);
    });
  });
}
