import 'package:flrx/navigation/route_retriever.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  static Router router = Router();

  @Deprecated("Modules will auto register the routes")
  static void init([RouteRetriever retriever]) {
    _registerRouteRetriever(retriever);
  }

  static void _registerRouteRetriever(RouteRetriever retriever) {
    _registerNotFoundHandler(retriever: retriever);

    retriever?.getRoutes()?.forEach((String route, Handler handler) {
      router.define(route, handler: handler);
    });
  }

  static void _registerNotFoundHandler({
    RouteRetriever retriever,
    RouteWidgetBuilder builder,
  }) {
    Handler notFoundHandler =
        _handlerForWidgetRoute(builder) ?? retriever?.getNotFoundHandler();

    if (notFoundHandler != null) {
      router.notFoundHandler = notFoundHandler;
    }
  }

  /// Sets a default [RouteWidgetBuilder] when no route matches. Similar to a 404 Page.
  static void setNotFoundWidget(RouteWidgetBuilder builder) =>
      _registerNotFoundHandler(builder: builder);

  static void registerRoute(String route, RouteWidgetBuilder builder) {
    router.define(route, handler: _handlerForWidgetRoute(builder));
  }

  static Handler _handlerForWidgetRoute(RouteWidgetBuilder builder) {
    return Handler(handlerFunc: (context, args) => builder(args));
  }
}

typedef RouteWidgetBuilder = Widget Function(Map<String, List<String>> params);
