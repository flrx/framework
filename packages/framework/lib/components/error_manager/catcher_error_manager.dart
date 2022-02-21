import 'package:catcher/catcher.dart';
import 'package:flrx/application.dart';
import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flutter/widgets.dart';

class CatcherErrorManager extends ErrorManager {
  final CatcherConfig catcherConfig;
  final GlobalKey<NavigatorState>? navigatorKey;

  CatcherErrorManager({required this.catcherConfig, this.navigatorKey});

  @override
  void init(VoidCallback runAppFunction) {
    var catcher = Catcher(
      runAppFunction: runAppFunction,
      debugConfig: catcherConfig.catcherDebugOptions(),
      profileConfig: catcherConfig.catcherProfileOptions(),
      releaseConfig: catcherConfig.catcherReleaseOptions(),
      enableLogger: catcherConfig.isLoggingEnabled(),
      navigatorKey: navigatorKey,
    );

    Application.serviceLocator.registerSingleton<Catcher>(catcher);
  }

  @override
  void reportCheckedError(error, stackTrace) {
    Catcher.reportCheckedError(error, stackTrace);
  }
}

class CatcherConfig {
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
