import 'package:redux/redux.dart';

abstract class ViewModel<State> {
  const ViewModel();

  void init(Store<State> store);
}
