import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/registrar/service_registrar.dart';

class Application {
  static final ServiceRegistrar registrar = ServiceRegistrar();

  static void init(void Function() initApp,
      void Function(ServiceRegistrar) setupSingletons) {
    setupSingletons(registrar);
    ErrorHandler.init(reporter: get<ErrorReporter>()).runApp(initApp);
  }

  static T get<T>() => registrar<T>();
}
