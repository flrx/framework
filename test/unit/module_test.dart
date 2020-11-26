import 'package:flrx/application.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import '../mocks/mock_error_reporter.dart';
import '../mocks/mock_module.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
    AppRouter.router = FluroRouter();
  });

  test('That modules can register an instance in service locator', () async {
    Module module = MockModule();

    await module.initialize();

    var reporter = Application.get<ErrorReporter>();
    expect(reporter is MockErrorReporter, true);
  });

  test('That modules can register routes', () async {
    Module module = MockModule();
    var router = AppRouter.router;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, false);

    expect(routeHandlerForPath(router, '/') != null, true);
    expect(routeHandlerForPath(router, '/mock') != null, true);
  });

  test('That modules can register route that are namespaced', () async {
    Module module = MockModuleWithNamespacedRoute();

    var router = AppRouter.router;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, true);
    expect(routeHandlerForPath(router, 'mock/') != null, true);
    expect(routeHandlerForPath(router, '/mock/') != null, true);
    expect(routeHandlerForPath(router, '/mock/mock') != null, true);
    expect(routeHandlerForPath(router, 'mock/mock') != null, true);
  });

  test('That modules can register route that are namespaced', () async {
    Module module = MockModuleWithInvalidRoutes();
    try {
      await module.initialize();
      fail('Module did not throw exception');
    } catch (exception) {
      expect(exception is ArgumentError, true);
    }
  });
}

Handler routeHandlerForPath(router, path) => router.match(path)?.route?.handler;
