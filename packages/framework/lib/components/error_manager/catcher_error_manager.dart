import 'package:catcher/catcher.dart';
import 'package:flrx/application.dart';
import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flutter/widgets.dart';

class CatcherErrorManager extends ErrorManager {
  final CatcherConfig catcherConfig;
  final GlobalKey<NavigatorState>? navigatorKey;

  CatcherErrorManager({required this.catcherConfig, this.navigatorKey});

  @override
  Future<void> init(VoidCallback runAppFunction) async {
    var catcher = Catcher(
      runAppFunction: runAppFunction,
      debugConfig: await catcherConfig.catcherDebugOptions(),
      profileConfig: await catcherConfig.catcherProfileOptions(),
      releaseConfig: await catcherConfig.catcherReleaseOptions(),
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
  Future<CatcherOptions> catcherDebugOptions() async {
    return CatcherOptions.getDefaultDebugOptions();
  }

  Future<CatcherOptions> catcherProfileOptions() async {
    return CatcherOptions.getDefaultProfileOptions();
  }

  Future<CatcherOptions> catcherReleaseOptions() async {
    return CatcherOptions.getDefaultReleaseOptions();
  }

  bool isLoggingEnabled() => true;

  ErrorWidgetBuilder? get defaultErrorWidgetBuilder {
    Catcher.addDefaultErrorWidget();

    return ErrorWidget.builder;
  }
}
