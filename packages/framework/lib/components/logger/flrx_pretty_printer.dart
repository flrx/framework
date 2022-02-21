import 'package:logger/logger.dart';

class FlrxPrettyPrinter extends PrettyPrinter {
  int _errorMethodCount = 8;

  @override
  int get errorMethodCount => _errorMethodCount;

  /// [PrettyPrinter] assumes if [event.stackTrace] is provided,
  /// [errorMethodCount] lines are printed in log,
  /// incorrectly assuming that the [event] is from an error.
  /// So we make sure that if error exists,
  /// then we force [PrettyPrinter] to handle it as an error,
  /// printing [errorMethodCount]. If [event.error] is not null then we force
  /// [PrettyPrinter] to print [methodCount] lines.
  @override
  List<String> log(LogEvent event) {
    var stackTrace = event.stackTrace ?? StackTrace.current;

    if (event.error != null) {
      return super.log(
        LogEvent(event.level, event.message, event.error, stackTrace),
      );
    }

    return handleAsRegularLog(event, stackTrace);
  }

  List<String> handleAsRegularLog(LogEvent event, StackTrace stackTrace) {
    var originalErrorMethodCount = _errorMethodCount;
    _errorMethodCount = methodCount;
    var output = super.log(
      LogEvent(
        event.level,
        event.message,
        event.error,
        removeFlrxFromStackTrace(stackTrace),
      ),
    );
    _errorMethodCount = originalErrorMethodCount;

    return output;
  }

  StackTrace removeFlrxFromStackTrace(StackTrace stackTrace) {
    var stackTraceLines = (stackTrace).toString().split('\n');

    stackTraceLines
        .removeWhere((line) => line.contains('flrx/components/logger/'));

    return StackTrace.fromString(stackTraceLines.join('\n'));
  }

  StackTrace removeFlrxLoggerFromStackTrace(LogEvent event) {
    var stackTrace = event.stackTrace ?? StackTrace.current;
    var stackTraceLines = (stackTrace).toString().split('\n');

    stackTraceLines
        .removeWhere((line) => line.contains('flrx/components/logger/'));

    return StackTrace.fromString(stackTraceLines.join('\n'));
  }
}
