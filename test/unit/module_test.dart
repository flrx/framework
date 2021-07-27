import 'package:flrx/application.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.mocks.dart';
import '../mocks/mock_module.dart';

void main() {

  setUp(() async {
    await Application.serviceLocator.reset();
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

  test('Modules are registered and booted in proper order', () async {
    var mockLogger = MockLogger();
    Application.serviceLocator.registerSingleton<Logger>(mockLogger);

    await Application.registerModules([
      MockModule1(),
      MockModule2(),
    ]);

    verifyInOrder([
      mockLogger.log('Register Module 1'),
      mockLogger.log('Register Module 2'),
      mockLogger.log('Boot Module 1'),
      mockLogger.log('Boot Module 2'),
    ]);
  });
}

Handler? routeHandlerForPath(router, path) => router.match(path)?.route?.handler;
