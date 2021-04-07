import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/components/registrar/service_locator.dart';

class Application {
  static final ServiceLocator serviceLocator = ServiceLocator();

  /// The entry point into the framework. Takes an [initApp] function which will
  /// be called after framework is initialized and a List of [Module]s
  static Future<void> init(
    Future<void> Function() initApp, {
    List<Module> modules = const [],
  }) async {
    await registerModules(modules);

    return ErrorHandler.init(reporter: get<ErrorReporter>()).runApp(initApp);
  }

  static Future registerModules(List<Module> modules) async {
    // Wait for all modules to initialize
    await Future.wait(modules.map((module) => module.initialize()));

    // Wait for all modules to boot
    await Future.wait(modules.map((module) => module.boot()));
  }

  static T get<T extends Object>() => serviceLocator.get<T>();
}
