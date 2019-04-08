import 'package:flrx/application.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flrx/store/store_retriever.dart';
import 'package:redux/redux.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_store_retriever.dart';

void main() async {
  Application.registrar.registerSingleton<Logger>(ConsoleLogger());
  StoreRetriever<MockAppState> storeRetriever = MockStoreRetriever();

  test('count middlewares test', () {
    List<Middleware<MockAppState>> commonMiddlewares =
        storeRetriever.getCommonMiddlewares();
    List<Middleware<MockAppState>> moduleMiddlewares =
        storeRetriever.getModuleMiddlewares();
    List<Middleware<MockAppState>> allMiddlewares =
        storeRetriever.getMiddlewares();
    expect(commonMiddlewares.length + moduleMiddlewares.length,
        allMiddlewares.length);
  });

  test('test store reducer', () async {
    Store<MockAppState> store = await storeRetriever.retrieveStore();
    expect(store.reducer, storeRetriever.getPrimaryReducer());
  });

  test('test store retreiver primary reducer', () {
    Reducer<MockAppState> reducer = storeRetriever.getPrimaryReducer();
    expect(reducer, MockReducer.reduce);
  });

  test('test store retreiver initial state', () {
    expect(storeRetriever.getInitialState().mockData,
        MockAppState.initialState().mockData);
  });
}
