import 'package:flrx/application.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

import '../mocks/mock_error_reporter.dart';
import '../mocks/mock_module.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
    AppRouter.router = Router();
  });

  test("That modules can register an instance in service locator", () async {
    Module module = MockModule();

    await module.initialize();

    ErrorReporter reporter = Application.get<ErrorReporter>();
    expect(reporter is MockErrorReporter, true);
  });

  test("That modules can register routes", () async {
    Module module = MockModule();
    Router router = AppRouter.router;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, false);
    expect(router.match("/").route.handler != null, true);
    expect(router.match("/mock").route.handler != null, true);
  });

  test("That modules can register route that are namespaced", () async {
    Module module = MockModuleWithNamespacedRoute();

    Router router = AppRouter.router;

    await module.initialize();

    expect(module.shouldNamespaceRoutes, true);

    Handler handlerForPath(path) => router.match(path)?.route?.handler;

    expect(handlerForPath("mock/") != null, true); // 2
//    expect(handlerForPath("mock") != null, true); // 2
    expect(handlerForPath("/mock/") != null, true); // 1
//    expect(handlerForPath("/mock") != null, true);// 1

//    expect(handlerForPath("/mock/mock/") != null, true);
    expect(handlerForPath("/mock/mock") != null, true);
    expect(handlerForPath("mock/mock") != null, true);
//    expect(handlerForPath("mock/mock/") != null, true);

    // /mock/
    // /mock/mock
  });

  test("That modules can register route that are namespaced", () async {
    Module module = MockModuleWithInvalidRoutes();
    try {
      await module.initialize();
      fail("Module did not throw exception");
    } catch (exception) {
      expect(exception is ArgumentError, true);
    }
  });
}
