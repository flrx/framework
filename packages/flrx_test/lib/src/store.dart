import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

/// The [TestStore] is the exact same implementation as a [Store] except
/// for a few key changes. The [TestStore] keeps track of all dispatched actions
/// in the [dispatchedActions] and also allows to quickly switch up the state using
/// [setState]. An alternative approach would be to have this as a middleware.
class TestStore<State> implements Store<State> {
  /// The [Reducer] for your Store. Allows you to get the current reducer or
  /// replace it with a new one if need be.
  @override
  Reducer<State> reducer;

  final StreamController<State> _changeController;
  late State _state;
  late final List<NextDispatcher> _dispatchers;

  List<dynamic> dispatchedActions = [];

  /// Creates an instance of a Redux Store.
  ///
  /// The [reducer] argument specifies how the state should be changed in
  /// response to dispatched actions.
  ///
  /// The optional [initialState] argument defines the State of the store when
  /// the Store is first created.
  ///
  /// The optional [middleware] argument takes a list of [Middleware] functions
  /// or [MiddlewareClass]. See the [Middleware] documentation for information
  /// on how they are used.
  ///
  /// The [syncStream] argument allows you to use a synchronous
  /// [StreamController] instead of an async `StreamController` under the hood.
  /// By default, the Stream is async.
  TestStore(
    this.reducer, {
    required State initialState,
    List<Middleware<State>> middleware = const [],
    bool syncStream = false,

    /// If set to true, the Store will not emit onChange events if the new State
    /// that is returned from your [reducer] in response to an Action is equal
    /// to the previous state.
    ///
    /// Under the hood, it will use the `==` method from your State class to
    /// determine whether or not the two States are equal.
    bool distinct = false,
  }) : _changeController = StreamController.broadcast(sync: syncStream) {
    _state = initialState;
    _dispatchers = _createDispatchers(
      middleware,
      _createReduceAndNotify(distinct),
    );
  }

  /// Returns the current state of the app
  @override
  State get state => _state;

  /// A stream that emits the current state when it changes.
  ///
  /// ### Example
  ///
  ///     // First, create the Store
  ///     final store = new Store<int>(counterReducer, 0);
  ///
  ///     // Next, listen to the Store's onChange stream, and print the latest
  ///     // state to your console whenever the reducer produces a new State.
  ///     //
  ///     // We'll store the StreamSubscription as a variable so we can stop
  ///     // listening later.
  ///     final subscription = store.onChange.listen(print);
  ///
  ///     // Dispatch some actions, and see the printing magic!
  ///     store.dispatch("INCREMENT"); // prints 1
  ///     store.dispatch("INCREMENT"); // prints 2
  ///     store.dispatch("DECREMENT"); // prints 1
  ///
  ///     // When you want to stop printing the state to the console, simply
  ///     `cancel` your `subscription`.
  ///     subscription.cancel();
  @override
  Stream<State> get onChange => _changeController.stream;

  // Creates the base [NextDispatcher].
  //
  // The base NextDispatcher will be called after all other middleware provided
  // by the user have been run. Its job is simple: Run the current state through
  // the reducer, save the result, and notify any subscribers.
  NextDispatcher _createReduceAndNotify(bool distinct) {
    return (dynamic action) {
      final state = reducer(_state, action);

      if (distinct && state == _state) return;

      _state = state;
      _changeController.add(state);
    };
  }

  List<NextDispatcher> _createDispatchers(
    List<Middleware<State>> middleware,
    NextDispatcher reduceAndNotify,
  ) {
    final dispatchers = <NextDispatcher>[reduceAndNotify];

    // Convert each [Middleware] into a [NextDispatcher]
    for (var nextMiddleware in middleware.reversed) {
      final next = dispatchers.last;

      dispatchers.add(
        (dynamic action) => nextMiddleware(this, action, next),
      );
    }

    return dispatchers.reversed.toList();
  }

  /// Runs the action through all provided [Middleware], then applies an action
  /// to the state using the given [Reducer]. Please note: [Middleware] can
  /// intercept actions, and can modify actions or stop them from passing
  /// through to the reducer.
  @override
  dynamic dispatch(dynamic action) {
    debugPrint(action);
    dispatchedActions.add(action);

    return _dispatchers[0](action);
  }

  /// Closes down the Store so it will no longer be operational. Only use this
  /// if you want to destroy the Store while your app is running. Do not use
  /// this method as a way to stop listening to [onChange] state changes. For
  /// that purpose, view the [onChange] documentation.
  @override
  Future teardown() async {
    return _changeController.close();
  }

  void setState(State newState) {
    _state = newState;
    _changeController.add(state);
  }
}
