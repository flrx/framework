import 'package:flrx/pages/viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// A convenience mixin class that defines the structure of a page
///
/// The [Page] mixin provides a separation of concern between the
/// the actual rendered widget content from the state management of that
/// page.
///
/// `flrx-cli` can be used to automatically generate a widget with [Page] mixin
/// using the `make:page` command.
///
/// The [Page] mixin takes a [State] defined for the app and
/// a [ViewModel] defined for the widget using this mixin.
///
abstract class Page<State, V extends ViewModel<State>> {

  /// A function that will run when the [StoreConnector] in [Page] will
  /// initially be created.
  ///
  /// This can be useful for dispatching actions that fetch data for your Widget
  /// when it is first displayed.
  void onInit(Store<State> store) {}

  /// A function that will be run after the Widget is built the first time.
  ///
  /// This function is passed the initial `ViewModel` created by the [initViewModel]
  /// function.
  ///
  /// This can be useful for starting certain animations, such as showing
  /// Snackbars, after the Widget is built the first time.
  void onInitialBuild(V viewModel) {}

  /// A function to initialize the `ViewModel` for the current page
  ///
  /// The initialized `ViewModel` is then passed to the converter of [StoreConnector]
  V initViewModel();

  /// A function that will be run on State change, before the Widget is built.
  ///
  /// This can be useful for imperative calls to things like Navigator,
  /// TabController, etc
  void onWillChange(
    BuildContext context,
    V? previousViewModel,
    V newViewModel,
  ) {}

  /// A function building the logic for the page
  ///
  /// While using the page mixing the [build] function in the widget
  /// using it should be removed and [buildContent] function should
  /// be used in place of it.
  Widget build(BuildContext context) {
    return StoreConnector<State, V>(
      onInit: onInit,
      onInitialBuild: onInitialBuild,
      onWillChange: (V? previousViewModel, V newViewModel) => onWillChange(
        context,
        previousViewModel,
        newViewModel,
      ),
      onDidChange: (V? previousViewModel, V newViewModel) => onDidChange(
        context,
        previousViewModel,
        newViewModel,
      ),
      onDispose: onDispose,
      converter: (Store<State> store) => initViewModel()..init(store),
      builder: buildContent,
    );
  }

  /// A function to build the content of the page
  ///
  /// This function is exposed to the widget using the mixin for
  /// writing the rendering logic of the widget.
  Widget buildContent(BuildContext context, V viewModel);

  /// A function that will be run on State change, after the Widget is built.
  ///
  /// This can be useful for running certain animations after the build is
  /// complete.
  ///
  /// Note: For navigation purposes, please use [onWillChange].
  void onDidChange(
    BuildContext context,
    V? previousViewModel,
    V newViewModel,
  ) {}

  /// A function that will be run when the StoreConnector is removed from the
  /// Widget Tree.
  ///
  /// It is run in the [State.dispose] method.
  ///
  /// This can be useful for dispatching actions that remove stale data from
  /// your State tree.
  void onDispose(Store<State> store) {}
}
