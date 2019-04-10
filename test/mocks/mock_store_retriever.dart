import 'dart:convert';

import 'package:flrx/store/store_retriever.dart';
import 'package:redux/src/store.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist/src/serialization.dart';

class MockStoreRetriever extends StoreRetriever<MockAppState> {
  @override
  MockAppState getInitialState() {
    return MockAppState.initialState();
  }

  @override
  List<Middleware<MockAppState>> getModuleMiddlewares() {
    return <Middleware<MockAppState>>[mockMiddleware];
  }

  @override
  Reducer<MockAppState> getPrimaryReducer() {
    return MockReducer.reduce;
  }

  @override
  StorageEngine getStorageEngine() =>
      MemoryStorage(getSerializer().encode(getInitialState()));

  @override
  StateSerializer<MockAppState> getSerializer() {
    return JsonSerializer<MockAppState>(MockAppState.fromJson);
  }
}

class MockAppState {
  MockAppState(String mockData) {
    this.mockData = mockData;
  }

  factory MockAppState.initialState() {
    return MockAppState("");
  }

  String mockData;

  static MockAppState fromJson(dynamic jsonData) {
    return MockAppState(json.decode(jsonData));
  }

  String toJson() => json.encode(mockData);
}

class MockReducer {
  static MockAppState reduce(MockAppState prevMockAppState, dynamic action) {
    if (action is MockAction) {
      return MockAppState(action.mockData);
    }
    return prevMockAppState;
  }
}

class MockAction {
  String mockData = 'mockData';
}

class MockMiddlewareAction {}

void mockMiddleware<MockAppState>(
    Store<MockAppState> store, dynamic action, NextDispatcher next) {
  if (action is MockMiddlewareAction) {
    store.dispatch(MockAction);
  } else {
    next(action);
  }
}
