import 'package:flrx/components/logger/base_logger.dart';
import 'package:flutter/widgets.dart';

class ConsoleLogger extends Logger {
  @override
  void log(dynamic message) {
    if (message is FlutterErrorDetails) {
      FlutterError.dumpErrorToConsole(message);
    } else {
      debugPrint(message.toString());
    }
  }
}
