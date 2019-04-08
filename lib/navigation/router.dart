import 'package:flrx/navigation/route_retriever.dart';
import 'package:fluro/fluro.dart';

class AppRouter {
  static Router router;
  static void init(RouteRetriever retriever) {
    router = Router();
    router.notFoundHandler = retriever.getNotFoundHandler();
    retriever.getRoutes().forEach((String route, Handler handler) {
      router.define(route, handler: handler);
    });
  }

  static String generateParamRoute(String route, Map<String, String> params) {
    return route.replaceAllMapped(RegExp("(:[a-zA-Z_]+)"), (Match match) {
      if (match.groupCount > 0) {
        String paramName = match.group(0).substring(1);
        String param = params[paramName];
        if (param == null)
          throw ArgumentError(
              "Param cannot be null. $paramName is passed as null");
        return param;
      }
    });
  }
}
