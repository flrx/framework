import 'package:flrx/components/logger/base_logger.dart';
import 'package:flrx/store/middlewares/future.dart';
import 'package:logging/logging.dart' as nativeLogger;
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

// TODO(ibrahim-mubarak): Should be more configurable
abstract class StoreRetriever<State> {
  Reducer<State> getPrimaryReducer();

  State getInitialState();

  List<Middleware<State>> getModuleMiddlewares();

  Future<Store<State>> retrieveStore() async {
    // Load initial state
    final State initialState = await getPersistor().load();
    return Store<State>(getPrimaryReducer(),
        initialState: initialState ?? getInitialState(),
        middleware: getMiddlewares());
  }

  Persistor<State> getPersistor() {
    return Persistor<State>(
        storage: getStorageEngine(),
        serializer: getSerializer(),
        debug: true,
        throttleDuration: Duration(seconds: 5));
  }

  StateSerializer<State> getSerializer();

  StorageEngine getStorageEngine() => FlutterStorage();

  List<Middleware<State>> getCommonMiddlewares() {
    return <Middleware<State>>[
      _getReduxLoggingMiddleware(),
      thunkMiddleware,
      futureMiddleware,
      getPersistor().createMiddleware()
    ];
  }

  List<Middleware<State>> getMiddlewares() {
    List<Middleware<State>> resultingMiddlewares = getCommonMiddlewares();
    resultingMiddlewares.addAll(getModuleMiddlewares());
    return resultingMiddlewares;
  }

  Middleware<State> _getReduxLoggingMiddleware() {
    LoggingMiddleware<State> loggingMiddleware = LoggingMiddleware<State>(
      formatter: LoggingMiddleware.multiLineFormatter,
    );
    loggingMiddleware.logger.onRecord.where((nativeLogger.LogRecord record) {
      return record.loggerName == loggingMiddleware.logger.name;
    }).listen(log);
    return loggingMiddleware;
  }
}
