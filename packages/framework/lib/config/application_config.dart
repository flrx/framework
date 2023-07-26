import 'package:flrx/components/modules/module.dart';
import 'package:flrx/config/error_reporter_config.dart';
import 'package:flutter/cupertino.dart';

abstract class ApplicationConfig {
  const ApplicationConfig();

  List<Module> get modules;

  GlobalKey<NavigatorState> get navigatorKey;

  ErrorReporterConfig get errorReporterConfig => const ErrorReporterConfig();
}
