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
    WidgetRoute widgetRoute,
  }) {
    Handler notFoundHandler =
        _handlerForWidgetRoute(widgetRoute) ?? retriever?.getNotFoundHandler();

    if (notFoundHandler != null) {
      router.notFoundHandler = notFoundHandler;
    }
  }

  /// Sets a default [WidgetRoute] when no route matches. Similar to a 404 Page.
  static void setNotFoundWidget(WidgetRoute widgetRoute) =>
      _registerNotFoundHandler(widgetRoute: widgetRoute);

  static void registerRoute(String route, WidgetRoute widgetRoute) {
    router.define(route, handler: _handlerForWidgetRoute(widgetRoute));
  }

  static Handler _handlerForWidgetRoute(WidgetRoute widgetRoute) {
    return Handler(handlerFunc: (context, args) => widgetRoute(args));
  }
}

typedef WidgetRoute = Widget Function(Map<String, List<String>> params);
