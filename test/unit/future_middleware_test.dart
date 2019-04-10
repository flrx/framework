import 'dart:async';

import 'package:flrx/store/middlewares/future.dart';
import 'package:redux/redux.dart';
import 'package:test_api/test_api.dart';

class Action {}

void main() {
  group('Future Middleware', () {
    Store<String> store;
    List<String> logs;
    void loggingMiddleware<State>(
        Store<State> store, dynamic action, NextDispatcher next) {
      logs.add(action.toString());
      next(action);
    }

    String futureReducer(String state, dynamic action) {
      if (action is FuturePendingAction<Action>) {
        return action.toString();
      } else if (action is FutureSuccessAction<Action, String>) {
        return action.payload;
      } else if (action is FutureErrorAction) {
        return action.error.toString();
      } else {
        return state;
      }
    }

    setUp(() {
      store = Store<String>(futureReducer, middleware: <Middleware<String>>[
        loggingMiddleware,
        futureMiddleware
      ]);
      logs = <String>[];
    });

//    test('is a Redux Middleware', () {
//      expect(futureMiddleware, Middleware);
//    });

    group('FutureAction', () {
      test('can synchronously dispatch a pending action', () {
        final FutureAction<Action, String> action =
            FutureAction<Action, String>(
                future: Future<String>.value("Fetch Complete"));
        store.dispatch(action);
        expect(store.state, FuturePendingAction<Action>().toString());
      });

      test(
          'dispatches a FutureSuccessAction if the future completes successfully',
          () async {
        const String dispatchedAction = "Friend";
        final Future<String> future = Future<String>.value(dispatchedAction);
        final FutureAction<Action, String> action =
            FutureAction<Action, String>(future: future);

        store.dispatch(action);
        await future;
        expect(store.state, dispatchedAction);
      });

      test('dispatches a FutureRejectedAction if the future returns an error',
          () {
        final Exception exception = Exception("Error Message");
        final Future<String> future = Future<String>.error(exception);
        final FutureAction<Action, String> action =
            FutureAction<Action, String>(future: future);

        store.dispatch(action);
        expect(
          future.catchError((_) => store.state),
          completion(contains(exception.toString())),
        );
      });

      test('returns the result of the Future after it has been dispatched',
          () async {
        const String dispatchedAction = "Friend";
        final Future<String> future = Future<String>.value(dispatchedAction);
        final FutureAction<Action, String> action =
            FutureAction<Action, String>(future: future);

        store.dispatch(action);
        expect(await action.future, dispatchedAction);
      });

      test('returns the error of the Future after it has been dispatched',
          () async {
        final Exception exception = Exception("Khaaaaaaaaaan");
        final Future<String> future = Future<String>.error(exception);
        final FutureAction<Action, String> action =
            FutureAction<Action, String>(future: future);

        store.dispatch(action);
        expect(future.catchError((_) => store.state),
            completion(contains(exception.toString())));
      });

      test('dispatchs initial action through Store.dispatch', () async {
        FutureAction<Action, String> action = FutureAction<Action, String>(
            future: Future<String>.value("Friend"));

        store.dispatch(action);
        final String fulfilledAction = await action.future;
        expect(logs, <String>[
          action.toString(),
          FuturePendingAction<Action>().toString(),
          (FutureSuccessAction<Action, String>()..payload = fulfilledAction)
              .toString(),
        ]);
      });
    });
  });
}
