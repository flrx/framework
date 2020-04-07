import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/modules/module.dart';
import 'package:flrx/components/registrar/service_locator.dart';

class Application {
  static final ServiceLocator serviceLocator = ServiceLocator();

  static void init(void Function() initApp, {List<Module> modules = const []}) {
    registerModules(modules);
    ErrorHandler.init(reporter: get<ErrorReporter>()).runApp(initApp);
  }

  static void registerModules(List<Module> modules) {
    modules.forEach((module) => module.initialize());
  }

  static T get<T>() => serviceLocator.get<T>();
}
