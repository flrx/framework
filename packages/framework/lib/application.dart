import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/components/registrar/service_locator.dart';
import 'package:flrx/flrx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Application {
  static late Application instance;

  static ServiceLocator get serviceLocator => instance._serviceLocator;

  static ApplicationConfig get config => instance.appConfig;

  final ServiceLocator _serviceLocator = ServiceLocator();
  final ApplicationConfig appConfig;
  final AsyncValueGetter initApp;

  static bool get isInDebugMode {
    var inDebugMode = false;
    assert(inDebugMode = true);

    return inDebugMode;
  }

  /// The entry point into the framework. Takes an [initApp] function which will
  /// be called after framework is initialized and a List of [Module]s
  Application(
    this.initApp, {
    required this.appConfig,
  }) {
    instance = this;
  }

  Future<void> init() async {
    /// Catcher needs a method to run
    /// The method we provide catcher does the following
    /// 1. Register the modules
    /// 2. Call the original method to run, which in turn calls runApp

    /// The Completer is so we know when the runApp has started running.
    Completer initAppCompleter = Completer();

    /// Have to setup AppRouter before error management
    /// if we want to use Navigator Key
    withErrorManagement(() =>
        registerModules(appConfig.modules, registerRoutes: true)
            .then((_) => initApp())
            .then(initAppCompleter.complete));

    return initAppCompleter.future;
  }

  void withErrorManagement(AsyncValueGetter initApp) {
    var errorReporterConfig = appConfig.errorReporterConfig;
    var errorWidgetBuilder = errorReporterConfig.defaultErrorWidgetBuilder;
    ErrorWidget.builder = errorWidgetBuilder ?? ErrorWidget.builder;

    _serviceLocator.get<ErrorManager>().init(initApp);
  }

  Future registerModules(
    List<Module> modules, {
    required bool registerRoutes,
  }) async {
    // Wait for all modules to initialize
    await Future.forEach<Module>(modules, (module) => module.register());
    if (registerRoutes) {
      await Future.forEach<Module>(
        modules,
        (module) => module.registerRoutes(),
      );
    }
    // Wait for all modules to boot
    await Future.forEach<Module>(modules, (module) => module.boot());

    await Future.forEach<Module>(
      modules,
      (module) => registerModules(module.submodules, registerRoutes: false),
    );
  }

  static T get<T extends Object>() => serviceLocator.get<T>();

  static bool hasModuleWithName(String name) {
    return instance.appConfig.modules
            .firstWhereOrNull((module) => module.name == name) !=
        null;
  }
}
