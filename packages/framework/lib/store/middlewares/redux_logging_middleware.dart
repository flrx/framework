import 'package:flrx/components/logger/base_logger.dart';
import 'package:logging/logging.dart' as native_logger;
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

Middleware<State> getReduxLoggingMiddleware<State>() {
  var loggingMiddleware = LoggingMiddleware<State>(
    formatter: LoggingMiddleware.multiLineFormatter,
  );
  loggingMiddleware.logger.onRecord.where((native_logger.LogRecord record) {
    return record.loggerName == loggingMiddleware.logger.name;
  }).listen(log);

  return loggingMiddleware;
}
