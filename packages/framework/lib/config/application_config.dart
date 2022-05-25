import 'package:flrx/components/modules/module.dart';
import 'package:flrx/config/error_reporter_config.dart';

abstract class ApplicationConfig {
  const ApplicationConfig();

  List<Module> get modules;

  ErrorReporterConfig get errorReporterConfig => const ErrorReporterConfig();
}
