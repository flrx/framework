import 'package:flrx/application.dart';
import 'package:flrx/components/registrar/service_locator.dart';
import 'package:flrx/flrx.dart';
import 'package:flrx/navigation/widget_route.dart';

abstract class Module {
  String get name;

  bool get shouldNamespaceRoutes => true;

  ServiceLocator get locator => Application.serviceLocator;

  Map<String, WidgetRoute> routes();

  /// Function to register or provide classes
  Future<void> onInit() async {}

  Future<void> initialize() async {
    await onInit();

    routes().forEach((String route, WidgetRoute widgetRoute) {
      if (!route.startsWith("/")) {
        throw ArgumentError.value(
          route,
          "Route",
          "Should begin with '/' in module $name",
        );
      }

      if (shouldNamespaceRoutes) {
        route = "$name$route";
      }
      AppRouter.registerRoutes(route, widgetRoute);
    });
  }
}
