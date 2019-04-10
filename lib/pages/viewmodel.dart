import 'package:redux/redux.dart';

abstract class ViewModel<State> {
  ViewModel();

  void init(Store<State> store);
}
