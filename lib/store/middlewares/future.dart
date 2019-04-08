import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class FutureAction<A, P> {
  FutureAction({@required this.future});

  Future<P> future;

  @override
  String toString() => "FutureAction[type = $A, future = $future]";

  FuturePendingAction<A> _getPendingAction() => FuturePendingAction<A>();

  FutureSuccessAction<A, P> _getSuccessAction() => FutureSuccessAction<A, P>();

  FutureErrorAction<A> _getErrorAction() => FutureErrorAction<A>();
}

class FuturePendingAction<A> {
  @override
  String toString() => "FuturePendingAction[type = $A]";
}

class FutureSuccessAction<A, P> {
  P payload;

  @override
  String toString() => "FutureSuccessAction[type = $A, payload = $payload]";
}

class FutureErrorAction<A> {
  dynamic error;

  @override
  String toString() => "FutureErrorAction[type = $A, error = $error]";
}

void futureMiddleware<State>(
    Store<State> store, dynamic action, NextDispatcher next) {
  if (action is FutureAction) {
    store.dispatch(action._getPendingAction());
    action.future.then((dynamic value) {
      store.dispatch(action._getSuccessAction()..payload = value);
    }).catchError((dynamic error) {
      store.dispatch(action._getErrorAction()..error = error);
    });
  } else {
    next(action);
  }
}
