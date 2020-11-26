import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

Middleware<State> getReduxLoggingMiddleware<State>() {
  var loggingMiddleware = LoggingMiddleware<State>(
    formatter: LoggingMiddleware.multiLineFormatter,
  );
  var logger = loggingMiddleware.logger;
  logger.onRecord.where((LogRecord record) {
    return record.loggerName == logger.name;
  }).listen((LogRecord log) {

  });
  return loggingMiddleware;
}
