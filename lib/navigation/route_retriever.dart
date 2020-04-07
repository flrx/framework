import 'package:flrx/pages/page_not_found.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

@Deprecated("Use Modules instead")
abstract class RouteRetriever {
  Map<String, Handler> getCommonRoutes() {
    return <String, Handler>{"/": getRootHandler()};
  }

  Handler getRootHandler();

  Map<String, Handler> getModuleRoutes();

  Map<String, Handler> getRoutes() {
    Map<String, Handler> resultingRoutes = getCommonRoutes();
    resultingRoutes.addAll(getModuleRoutes());
    return Map<String, Handler>.unmodifiable(resultingRoutes);
  }

  Handler getNotFoundHandler() {
    Handler notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            PageNotFound());
    return notFoundHandler;
  }
}
