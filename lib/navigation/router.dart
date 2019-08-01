import 'package:flrx/navigation/route_retriever.dart';
import 'package:flrx/utils/string_utils.dart';
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

  @Deprecated('Use StringUtils.replaceWithValues() instead')
  static String generateParamRoute(String route, Map<String, String> params) =>
      StringUtils.replaceWithValues(route, params);
}
