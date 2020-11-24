import 'package:flrx/application.dart';
import 'package:flrx/components/registrar/service_locator.dart';
import 'package:flrx/flrx.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

abstract class Module {
  /// Name of the [Module]. This [name] will be used as namespace when prefixing
  /// it to the route.
  String get name;

  /// Sets when namespace should be prefixed to the routes.
  /// If your route is `/register` and your module name is `auth`, Then the
  /// resulting route will be `auth/register` when this returns true.
  bool get shouldNamespaceRoutes => true;

  /// [ServiceLocator] from [Application], provided here for convenience.
  ServiceLocator get locator => Application.serviceLocator;

  /// A method returning routes to be registered by the [Module],
  /// [RouteWidgetBuilder] provides the arguments by the navigator to the Widget.
  Map<String, RouteWidgetBuilder> routes();

  Module() {
    throwIf(
      shouldNamespaceRoutes && name == null,
      StateError(
          'Module name cannot be null when shouldNamespaceRoutes is true'),
    );
  }

  /// Function to register or provide classes. Override [register] when you want
  /// to write the logic for the initialization of the [Module].
  Future<void> register() async {}

  Future<void> boot() async {}

  @Deprecated('Use register instead')
  @mustCallSuper
  Future<void> onInit() => register();

  Future<void> initialize() async {
    await onInit();

    _registerRoutes();
  }

  void _registerRoutes() {
    routes().forEach((String route, RouteWidgetBuilder builder) {
      _validateRouteName(route);

      if (shouldNamespaceRoutes) {
        route = "$name$route";
      }
      AppRouter.registerRoute(route, builder);
    });
  }

  void _validateRouteName(String route) => throwIf(
        !route.startsWith("/"),
        ArgumentError.value(
            route, "Route", "Should begin with '/' in module $name"),
      );
}
