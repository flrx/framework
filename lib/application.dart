import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/registrar/service_locator.dart';

class Application {
  static final ServiceLocator serviceLocator = ServiceLocator();

  static void init(
      void Function() initApp, void Function(ServiceLocator) setupSingletons) {
    setupSingletons(serviceLocator);
    ErrorHandler.init(reporter: get<ErrorReporter>()).runApp(initApp);
  }

  static T get<T>() => serviceLocator.get<T>();
}
