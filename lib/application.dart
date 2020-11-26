import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/logger/base_logger.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/components/registrar/service_locator.dart';

class Application {
  static final ServiceLocator serviceLocator = ServiceLocator();

  /// The entry point into the framework. Takes an [initApp] function which will
  /// be called after framework is initialized and a List of [Module]s
  static Future<void> init(
    void Function() initApp, {
    @Deprecated('Use modules instead')
        void Function(ServiceLocator) setupSingletons,
    List<Module> modules = const [],
  }) async {
    if (setupSingletons != null) {
      setupSingletons(serviceLocator);
    }
    await Future.wait(modules.map((module) => module.initialize()));
    setupDefaults();
    ErrorHandler.init(reporter: get<ErrorReporter>()).runApp(initApp);
  }

  static T get<T>() => serviceLocator.get<T>();

  static void setupDefaults() {
    if (get<Logger>() == null) {

    }
  }
}
