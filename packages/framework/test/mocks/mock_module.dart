import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';

class MockModuleWithNamespacedRoute extends MockModule {
  @override
  bool get shouldNamespaceRoutes => true;

  @override
  List<BaseRoute> routes() {
    // TODO: implement routes
    throw UnimplementedError();
  }
}

class MockModule1 extends MockModule {
  @override
  bool get shouldNamespaceRoutes => true;

  @override
  Future<void> register() async {
    log('Register Module 1');
  }

  @override
  Future<void> boot() async {
    log('Boot Module 1');
  }

  @override
  List<BaseRoute> routes() {
    // TODO: implement routes
    throw UnimplementedError();
  }
}

class MockModule2 extends MockModule {
  @override
  Future<void> register() async {
    log('Register Module 2');
  }

  @override
  Future<void> boot() async {
    log('Boot Module 2');
  }

  @override
  List<BaseRoute> routes() {
    // TODO: implement routes
    throw UnimplementedError();
  }
}

class MockModuleWithInvalidRoutes extends MockModule {
  // @override
  // Map<String, RouteWidgetBuilder> routes() {
  //   return {
  //     MockModule.home: (args) => Container(),
  //     MockModule.invalidRoute: (args) => const Scaffold(),
  //   };
  // }
}

class MockModule extends Module {
  @override
  String get name => 'mock';

  static const home = '/';
  static const invalidRoute = 'invalid-route';
  static const mock = '/mock';

  @override
  bool get shouldNamespaceRoutes => false;

  // @override
  // Map<String, RouteWidgetBuilder> routes() {
  //   return {
  //     home: (args) => Container(),
  //     mock: (args) => const Scaffold(),
  //   };
  // }

  @override
  Future<void> register() async {
    locator.registerSingleton<RandomClass>(RandomClass());
  }

  @override
  List<BaseRoute> routes() {
    // TODO: implement routes
    throw UnimplementedError();
  }
}

class RandomClass {}
