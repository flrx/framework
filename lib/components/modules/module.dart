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

  /// Within the [register] method, you should only bind things into the service
  /// locator. You should never attempt to register any event listeners, routes,
  /// or any other piece of functionality within the register method.
  Future<void> register() async {}

  /// This method is called after all other [Module]s have been registered,
  /// meaning you have access to all other services that have been registered
  /// by the framework
  Future<void> boot() async {}

  @Deprecated('Use register instead')
  @mustCallSuper
  Future<void> onInit() => register();

  Future<void> initialize() async {
    await onInit();

    routes().forEach(registerRoute);
  }

  /// Register routes from the current [Module]
  /// This can be used to conditionally register routes from the [boot] method.
  void registerRoute(String route, RouteWidgetBuilder builder) {
    _validateRouteName(route);

    AppRouter.registerRoute(normalizeRoute(route), builder);
  }

  String normalizeRoute(String route) {
    if (shouldNamespaceRoutes) {
      if (route == '/') {
        route = '';
      }

      route = '/$name$route';
    }
    return route;
  }

  void _validateRouteName(String route) {
    throwIf(
      !route.startsWith('/'),
      ArgumentError.value(
          route, 'Route', "Should begin with '/' in module $name"),
    );
  }
}
