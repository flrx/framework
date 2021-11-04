import 'package:flrx/application.dart';
import 'package:flrx/components/logger/flrx_pretty_printer.dart';
import 'package:logger/logger.dart' as logging;

class Logger extends logging.Logger {
  Logger() : super(printer: FlrxPrettyPrinter());
}

/// [Level]s to control logging output. Logging can be enabled to include all
/// levels above certain [Level].
enum Level {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing,
}

void log(
  dynamic message, {
  Level level = Level.info,
  dynamic error,
  StackTrace? stackTrace,
}) =>
    Application.get<Logger>().log(
      logging.Level.values[level.index],
      message,
      error,
      stackTrace,
    );

Function _log = log;

extension FlrxLogExtensions<T extends dynamic> on T {
  T log({
    Level level = Level.info,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(this, level: level, error: error, stackTrace: stackTrace);

    return this;
  }
}
