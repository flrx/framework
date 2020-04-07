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
    Handler notFoundHandler = retriever?.getNotFoundHandler();

    if (notFoundHandler != null) {
      router.notFoundHandler = notFoundHandler;
    }

    retriever?.getRoutes()?.forEach((String route, Handler handler) {
      router.define(route, handler: handler);
    });
  }

  static void registerRoutes(String route, WidgetRoute widgetRoute) {
    router.define(route, handler: handlerForWidgetRoute(widgetRoute));
  }

  static Handler handlerForWidgetRoute(WidgetRoute widgetRoute) {
    return Handler(handlerFunc: (context, args) => widgetRoute.builder(args));
  }
}
