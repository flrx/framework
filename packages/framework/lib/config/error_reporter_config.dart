import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ErrorReporterConfig {
  const ErrorReporterConfig();

  bool isLoggingEnabled() => true;

  ErrorWidgetBuilder? get defaultErrorWidgetBuilder {
    return ErrorWidget.builder;
  }
}
