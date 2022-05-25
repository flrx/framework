import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart' as log;
import 'package:mockito/mockito.dart';

import '../mocks.mocks.dart';
import '../mocks/mock_config.dart';
import '../mocks/mock_module.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Application.serviceLocator.reset();
    // AppRouter.router = FluroRouter();
  });

  test('That modules can register an instance in service locator', () async {
    Module module = MockModule();

    await module.initialize();

    var instance = Application.get<RandomClass>();
    expect(instance is RandomClass, true);
  });

  test('That modules can register routes', () async {
    Module module = MockModule();
    // var router = AppRouter.goRouter;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, false);

    // expect(routeHandlerForPath(router, '/') != null, true);
    // expect(routeHandlerForPath(router, '/mock') != null, true);
  });

  test('That modules can register route that are namespaced', () async {
    Module module = MockModuleWithNamespacedRoute();

    // var router = AppRouter.goRouter;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, true);
    // expect(routeHandlerForPath(router, 'mock/') != null, true);
    // expect(routeHandlerForPath(router, '/mock/') != null, true);
    // expect(routeHandlerForPath(router, '/mock/mock') != null, true);
    // expect(routeHandlerForPath(router, 'mock/mock') != null, true);
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

    Application(
      () async {},
      appConfig: MockConfig([
        MockModule1(),
        MockModule2(),
      ]),
    ).init();

    verifyInOrder([
      mockLogger.log(log.Level.info, 'Register Module 1'),
      mockLogger.log(log.Level.info, 'Register Module 2'),
      mockLogger.log(log.Level.info, 'Boot Module 1'),
      mockLogger.log(log.Level.info, 'Boot Module 2'),
    ]);
  });
}

// Handler? routeHandlerForPath(router, path) =>
//     router.match(path)?.route?.handler;
