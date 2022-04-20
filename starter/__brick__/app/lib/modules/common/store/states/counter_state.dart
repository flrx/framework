class CounterState {
  int _counter = 0;

  int get counter => _counter;

  CounterState(this._counter);

  factory CounterState.initialState() => CounterState(0);
}
