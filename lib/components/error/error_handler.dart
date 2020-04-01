import 'dart:async';

import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flrx/config/config.dart';
import 'package:flutter/widgets.dart';

class ErrorHandler {
  //Create new Error Handler
  factory ErrorHandler.init({@required ErrorReporter reporter}) {
    _instance ??= ErrorHandler._internal(reporter);
    return _instance;
  }

  ErrorHandler._internal(this.reporter)
      : reportErrorOnDebug = reporter.reportOnDebug ?? false {
    _setupFlutterErrorHandler();
  }

  static void dispose() => _instance = null;

  final ErrorReporter reporter;

  static ErrorHandler _instance;

  final bool reportErrorOnDebug;

  static ErrorHandler get instance {
    return _instance;
  }

  void _setupFlutterErrorHandler() {
    // This captures errors reported by the Flutter framework.
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (Config.isInDebugMode && !reportErrorOnDebug) {
        // In development mode and Debug Mode reporting is disabled. Simply log it
        log(details);
      } else {
        // In production mode report to the application zone
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };
  }

  void runApp(Function appFunction) {
    runZonedGuarded(() async {
      appFunction();
    }, reportError);
  }

  void reportError(dynamic error, StackTrace stackTrace) async {
    if (Config.isInDebugMode && !reportErrorOnDebug) {
      log('Caught error: $error');
      log(stackTrace);
      log('In dev mode. Not reporting Error');
      return;
    }
    _instance.reporter.reportError(error, stackTrace);
  }
}
