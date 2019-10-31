import 'package:flrx/application.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flrx/store/store_retriever.dart';
import 'package:redux/redux.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_store_retriever.dart';

void main() async {
  Application.serviceLocator.registerSingleton<Logger>(ConsoleLogger());
  StoreRetriever<MockAppState> storeRetriever = MockStoreRetriever();

  test('test store reducer', () async {
    Store<MockAppState> store = await storeRetriever.retrieveStore();
    expect(store.reducer, storeRetriever.getPrimaryReducer());
  });

  test('test store retreiver primary reducer', () {
    Reducer<MockAppState> reducer = storeRetriever.getPrimaryReducer();
    expect(reducer, MockReducer.reduce);
  });

  test('test store retreiver initial state', () async {
    MockAppState initialState = await storeRetriever.getInitialState();
    expect(initialState.mockData, MockAppState.initialState().mockData);
  });
}
