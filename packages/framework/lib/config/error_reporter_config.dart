import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ErrorReporterConfig {
  const ErrorReporterConfig();

  bool isLoggingEnabled() => true;

  ErrorWidgetBuilder? get defaultErrorWidgetBuilder {
    Catcher.addDefaultErrorWidget();

    return ErrorWidget.builder;
  }
}
