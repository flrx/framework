import 'package:flrx/navigation/route_retriever.dart';
import 'package:flrx/navigation/widget_route.dart';
import 'package:fluro/fluro.dart';

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

  static void setNotFoundWidget(WidgetRoute widgetRoute) =>
      _registerNotFoundHandler(widgetRoute: widgetRoute);

  static void registerRoute(String route, WidgetRoute widgetRoute) {
    router.define(route, handler: _handlerForWidgetRoute(widgetRoute));
  }

  static Handler _handlerForWidgetRoute(WidgetRoute widgetRoute) {
    return Handler(handlerFunc: (context, args) => widgetRoute.builder(args));
  }
}
