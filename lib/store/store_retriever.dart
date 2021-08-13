import 'package:redux/redux.dart';

// TODO(ibrahim-mubarak): Should be more configurable
abstract class StoreRetriever<State> {
  const StoreRetriever();

  Reducer<State> getPrimaryReducer();

  Future<State> getInitialState();

  Future<Store<State>> retrieveStore() async {
    // Load initial state
    return Store<State>(getPrimaryReducer(),
        initialState: await getInitialState(), middleware: getMiddlewares());
  }

  List<Middleware<State>> getMiddlewares();
}
