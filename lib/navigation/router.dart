import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  static FluroRouter router = FluroRouter();

  static Map<String, RouteWidgetBuilder> registeredRoutes = {};

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
    router.define(route, handler: _handlerForWidgetRoute(builder));
    registeredRoutes[route] = builder;
  }

  static void printRegisteredRoutes() {
    var routeWidgetList = <String, String>{};
    var longestRoute = '/';

    registeredRoutes.forEach((route, RouteWidgetBuilder builder) {
      if (route.length > longestRoute.length) {
        longestRoute = route;
      }

      routeWidgetList[route] = _widgetNameFromBuilder(builder);
    });

    List routes = routeWidgetList.keys.toList()..sort((a, b) => a.compareTo(b));

    routes.forEach((route) => print('$route => ${routeWidgetList[route]}'));
  }

  static String _widgetNameFromBuilder(RouteWidgetBuilder builder) {
    var builderString = builder.toString();
    return builderString.substring(builderString.indexOf('=>') + 2);
  }

  static Handler _handlerForWidgetRoute(RouteWidgetBuilder builder) {
    return Handler(handlerFunc: (context, args) => builder(args));
  }
}

typedef RouteWidgetBuilder = Widget Function(Map<String, List<String>> params);
