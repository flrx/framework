import 'dart:convert';

import 'package:flrx/store/store_retriever.dart';
import 'package:redux/src/store.dart';

class MockStoreRetriever extends StoreRetriever<MockAppState> {
  @override
  Future<MockAppState> getInitialState() async {
    return MockAppState.initialState();
  }

  @override
  Reducer<MockAppState> getPrimaryReducer() {
    return MockReducer.reduce;
  }

  @override
  List<Middleware<MockAppState>> getMiddlewares() => [
        mockMiddleware,
      ];
}

class MockAppState {
  String? mockData;

  MockAppState(this.mockData);

  factory MockAppState.initialState() {
    return MockAppState('');
  }

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
  Store<MockAppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is MockMiddlewareAction) {
    store.dispatch(MockAction);
  } else {
    next(action);
  }
}
