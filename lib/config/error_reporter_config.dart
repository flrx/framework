import 'package:catcher/catcher.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ErrorReporterConfig {
  const ErrorReporterConfig();

  CatcherOptions catcherDebugOptions() {
    return CatcherOptions.getDefaultDebugOptions();
  }

  CatcherOptions catcherProfileOptions() {
    return CatcherOptions.getDefaultProfileOptions();
  }

  CatcherOptions catcherReleaseOptions() {
    return CatcherOptions.getDefaultReleaseOptions();
  }

  bool isLoggingEnabled() => true;

  ErrorWidgetBuilder? get defaultErrorWidgetBuilder {
    Catcher.addDefaultErrorWidget();

    return ErrorWidget.builder;
  }
}
