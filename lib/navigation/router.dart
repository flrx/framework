import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  static FluroRouter router = FluroRouter();

  static void _registerNotFoundHandler({
    required RouteWidgetBuilder builder,
  }) {
    router.notFoundHandler = _createHandlerFromRouteWidgetBuilder(builder);
  }

  /// Sets a default [RouteWidgetBuilder] when no route matches. Similar to a 404 Page.
  static void setNotFoundWidget(RouteWidgetBuilder builder) =>
      _registerNotFoundHandler(builder: builder);

  static void registerRoute(String route, RouteWidgetBuilder builder) {
    router.define(route,
        handler: _createHandlerFromRouteWidgetBuilder(builder));
  }

  static Handler _createHandlerFromRouteWidgetBuilder(
      RouteWidgetBuilder builder) {
    return Handler(handlerFunc: (context, args) => builder(args));
  }
}

typedef RouteWidgetBuilder = Widget Function(Map<String, List<String>> params);
