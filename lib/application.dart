import 'package:catcher/catcher.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/components/registrar/service_locator.dart';
import 'package:flrx/config/application_config.dart';
import 'package:flutter/widgets.dart';

class Application {
  static final ServiceLocator serviceLocator = ServiceLocator();

  static late final ApplicationConfig _config;

  static bool get isInDebugMode {
    var inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  /// The entry point into the framework. Takes an [initApp] function which will
  /// be called after framework is initialized and a List of [Module]s
  static Future<void> init(
    Future<void> Function() initApp, {
    required ApplicationConfig config,
  }) async {
    Application._config = config;

    await registerModules();

    setupErrorManagement(config, initApp);
  }

  static void setupErrorManagement(
    ApplicationConfig config,
    Function() initApp,
  ) {
    var errorReporterConfig = config.errorReporterConfig;

    if (errorReporterConfig.defaultErrorWidgetBuilder != null) {
      ErrorWidget.builder = errorReporterConfig.defaultErrorWidgetBuilder!;
    }

    var catcher = Catcher(
      runAppFunction: initApp,
      debugConfig: errorReporterConfig.catcherDebugOptions(),
      profileConfig: errorReporterConfig.catcherProfileOptions(),
      releaseConfig: errorReporterConfig.catcherReleaseOptions(),
      enableLogger: errorReporterConfig.isLoggingEnabled(),
      navigatorKey: config.navigatorKey,
    );

    Application.serviceLocator.registerSingleton<Catcher>(catcher);
  }

  static Future registerModules() async {
    // Wait for all modules to initialize
    await Future.forEach<Module>(
      _config.modules,
      (module) => module.initialize(),
    );

    // Wait for all modules to boot
    await Future.forEach<Module>(
      _config.modules,
      (module) => module.boot(),
    );
  }

  static T get<T extends Object>() => serviceLocator.get<T>();

  static ApplicationConfig get config => _config;
}
