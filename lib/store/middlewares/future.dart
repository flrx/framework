import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class FutureAction<A, P> {
  FutureAction({@required this.future, this.extras});

  Future<P> future;

  Map<String, dynamic> extras;

  @override
  String toString() => "FutureAction[type = $A, future = $future]";

  FuturePendingAction<A> _getPendingAction() =>
      FuturePendingAction<A>(extras: extras);

  FutureSuccessAction<A, P> _getSuccessAction() =>
      FutureSuccessAction<A, P>(extras: extras);

  FutureErrorAction<A> _getErrorAction() =>
      FutureErrorAction<A>(extras: extras);
}

class FuturePendingAction<A> {
  FuturePendingAction({this.extras});

  Map<String, dynamic> extras;

  @override
  String toString() => "FuturePendingAction[type = $A]";
}

class FutureSuccessAction<A, P> {
  FutureSuccessAction({this.extras});

  Map<String, dynamic> extras;

  P payload;

  @override
  String toString() => "FutureSuccessAction[type = $A, payload = $payload]";
}

class FutureErrorAction<A> {
  FutureErrorAction({this.extras});

  Map<String, dynamic> extras;

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

bool isActionOfFutureType<A, P>(dynamic action) {
  return action is FutureAction<A, P> ||
      action is FutureSuccessAction<A, P> ||
      action is FuturePendingAction<A> ||
      action is FutureErrorAction<A>;
}
