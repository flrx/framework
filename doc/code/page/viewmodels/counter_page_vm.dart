import 'package:example/store/actions/actions.dart';
import 'package:example/store/states/app_state.dart';
import 'package:flrx/pages/viewmodel.dart';
import 'package:redux/redux.dart';

class CounterPageVM extends ViewModel<AppState> {
  int counter;

  void Function(dynamic) dispatch;

  @override
  void init(Store<AppState> store) {
    dispatch = store.dispatch;
    counter = store.state.counter;
  }

  void incrementCounter() => dispatch(IncrementAction());
}
