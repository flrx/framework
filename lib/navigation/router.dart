import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/widgets.dart';

class AppRouter {
  static Fluro.Router router = Fluro.Router();

  static void _registerNotFoundHandler({
    RouteWidgetBuilder builder,
  }) {
    var notFoundHandler = _handlerForWidgetRoute(builder);

    if (notFoundHandler != null) {
      router.notFoundHandler = notFoundHandler;
    }
  }

  /// Sets a default [RouteWidgetBuilder] when no route matches. Similar to a 404 Page.
  static void setNotFoundWidget(RouteWidgetBuilder builder) =>
      _registerNotFoundHandler(builder: builder);

  static void registerRoute(String route, RouteWidgetBuilder builder) {
    router.define(route, handler: _handlerForWidgetRoute(builder), transitionType: Fluro.TransitionType.custom);
  }

  static Fluro.Handler _handlerForWidgetRoute(RouteWidgetBuilder builder) {
    return Fluro.Handler(handlerFunc: (context, args) => builder(args));
  }
}

typedef RouteWidgetBuilder = Widget Function(Map<String, List<String>> params);
