import 'package:flrx/application.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flrx/store/store_retriever.dart';
import 'package:test/test.dart';

import '../mocks/mock_store_retriever.dart';

void main() async {
  Application.serviceLocator.registerSingleton<Logger>(ConsoleLogger());
  StoreRetriever<MockAppState> storeRetriever = MockStoreRetriever();

  test('test store reducer', () async {
    var store = await storeRetriever.retrieveStore();
    expect(store.reducer, storeRetriever.getPrimaryReducer());
  });

  test('test store retreiver primary reducer', () {
    var reducer = storeRetriever.getPrimaryReducer();
    expect(reducer, MockReducer.reduce);
  });

  test('test store retreiver initial state', () async {
    var initialState = await storeRetriever.getInitialState();
    expect(initialState.mockData, MockAppState.initialState().mockData);
  });
}
