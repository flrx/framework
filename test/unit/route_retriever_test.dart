import 'package:flrx/navigation/route_retriever.dart';
import 'package:fluro/fluro.dart';
import 'package:test/test.dart';

import '../mocks/mock_route_retriever.dart';

void main() {
  RouteRetriever retriever = MockRouteRetriever();
  test('count_total_routes_test', () {
    Map<String, Handler> commonRoutes = retriever.getCommonRoutes();
    Map<String, Handler> moduleRoutes = retriever.getModuleRoutes();
    expect(commonRoutes.length + moduleRoutes.length,
        retriever.getRoutes().length);
  });
}
