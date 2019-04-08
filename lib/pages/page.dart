import 'package:flrx/pages/viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

abstract class Page<State, V extends ViewModel<State>> {
  void onInit(Store<State> store) {}

  void onInitialBuild(V viewModel) {}

  V initViewModel();

  void onWillChange(BuildContext context, V viewModel) {}

  Widget build(BuildContext context) {
    return StoreConnector<State, V>(
      onInit: onInit,
      onInitialBuild: onInitialBuild,
      onWillChange: (V viewModel) => onWillChange(context, viewModel),
      onDidChange: (V viewModel) => onDidChange(context, viewModel),
      onDispose: onDispose,
      converter: (Store<State> store) => initViewModel()..init(store),
      builder: buildContent,
    );
  }

  Widget buildContent(BuildContext context, V vm);

  void onDidChange(BuildContext context, V viewModel) {}

  void onDispose(Store<State> store) {}
}
