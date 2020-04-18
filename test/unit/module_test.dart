import 'package:flrx/application.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:flrx/navigation/widget_route.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

class MockModuleWithNamespacedRoute extends MockModule {
  @override
  bool get shouldNamespaceRoutes => true;
}

class MockModule extends Module {
  @override
  String get name => "mock";

  @override
  bool get shouldNamespaceRoutes => false;

  @override
  Map<String, WidgetRoute> routes() {
    return {
      "/": WidgetRoute((args) => Container()),
      "/mock": WidgetRoute((args) => Scaffold()),
    };
  }

  @override
  Future<void> onInit() async {
    locator.registerSingleton<Divider>(Divider());
  }
}

void main() {
  setUp(() {
    GetIt.instance.reset();
    AppRouter.router = Router();
  });

  test("That modules can register an instance in service locator", () async {
    Module module = MockModule();

    await module.initialize();

    Divider divider = Application.get<Divider>();
    expect(divider is Divider, true);
  });

  test("That modules can register routes", () async {
    Module module = MockModule();
    Router router = AppRouter.router;

    await module.initialize();

    expect(router.match("/").route.handler != null, true);
    expect(router.match("/mock").route.handler != null, true);
  });

  test("That modules can register route that are namespaced", () async {
    Module module = MockModuleWithNamespacedRoute();

    Router router = AppRouter.router;

    await module.initialize();

    expect(router.match("mock/").route.handler != null, true); // 2
//    expect(router.match("mock").route.handler != null, true); // 2
    expect(router.match("/mock/").route.handler != null, true); // 1
//    expect(router.match("/mock").route.handler != null, true);// 1

//    expect(router.match("/mock/mock/").route.handler != null, true);
    expect(router.match("/mock/mock").route.handler != null, true);
    expect(router.match("mock/mock").route.handler != null, true);
//    expect(router.match("mock/mock/").route.handler != null, true);

    // /mock/
    // /mock/mock
  });
}
