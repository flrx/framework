import 'package:flrx/components/error/error.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/navigation/router.dart';
import 'package:flutter/material.dart';

import 'mock_error_reporter.dart';

class MockModuleWithNamespacedRoute extends MockModule {
  @override
  bool get shouldNamespaceRoutes => true;
}

class MockModuleWithInvalidRoutes extends MockModule {
  @override
  Map<String, RouteWidgetBuilder> routes() {
    return {
      MockModule.HOME: (args) => Container(),
      MockModule.INVALID_ROUTE: (args) => Scaffold(),
    };
  }
}

class MockModule extends Module {
  @override
  String get name => 'mock';

  static const HOME = '/';
  static const INVALID_ROUTE = 'invalid-route';
  static const MOCK = '/mock';

  @override
  bool get shouldNamespaceRoutes => false;

  @override
  Map<String, RouteWidgetBuilder> routes() {
    return {
      HOME: (args) => Container(),
      MOCK: (args) => Scaffold(),
    };
  }

  @override
  Future<void> register() {
    locator.registerSingleton<ErrorReporter>(MockErrorReporter());
  }
}
