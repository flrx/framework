import 'package:flrx/store/middlewares/redux_logging_middleware.dart';
import 'package:flrx/store/store_retriever.dart';
import 'package:{{name}}/store/reducers/app_state_reducer.dart';
import 'package:{{name}}/store/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_future_middleware/redux_future_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppStoreRetriever extends StoreRetriever<AppState> {
  @override
  List<Middleware<AppState>> getMiddlewares() {
    return <Middleware<AppState>>[
      thunkMiddleware,
      futureMiddleware,
      getReduxLoggingMiddleware(),
    ];
  }

  @override
  Future<AppState> getInitialState() async => AppState.initialState();

  @override
  Reducer<AppState> getPrimaryReducer() => AppStateReducer.reduce;
}
