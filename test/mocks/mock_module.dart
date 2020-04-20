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
  Map<String, WidgetRoute> routes() {
    return {
      "/": (args) => Container(),
      "invalid-route": (args) => Scaffold(),
    };
  }
}

class MockModule extends Module {
  @override
  String get name => "mock";

  @override
  bool get shouldNamespaceRoutes => false;

  @override
  Map<String, WidgetRoute> routes() {
    return {
      "/": (args) => Container(),
      "/mock": (args) => Scaffold(),
    };
  }

  @override
  Future<void> onInit() async {
    locator.registerSingleton<ErrorReporter>(MockErrorReporter());
  }
}
