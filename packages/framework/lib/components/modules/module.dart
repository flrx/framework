import 'package:flrx/components/registrar/service_locator.dart';
import 'package:flrx/flrx.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

abstract class Module {
  const Module();

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
  List<BaseRoute> routes();

  List<Module> get submodules => [];

  /// The root widget of the [Module], which will be provided as an ancestor to
  /// all the routes registered by the [Module].
  Widget rootWidgetBuilder(
    BuildContext context,
    Widget child,
  ) =>
      child;

  /// Within the [register] method, you should only bind things into the service
  /// locator. You should never attempt to register any event listeners, routes,
  /// or any other piece of functionality within the register method.
  Future<void> register() async {}

  /// This method is called after all other [Module]s have been registered,
  /// meaning you have access to all other services that have been registered
  /// by the framework
  Future<void> boot() async {}

  void registerRoutes() {
    /// Gets all routes as siblings
    List<BaseRoute> finalRouteList = routes();
    int moduleRootRouteIndex = finalRouteList
        .cast<BaseRoute?>()
        .indexWhere((element) => element?.path == '/');

    if (moduleRootRouteIndex == -1) {
      finalRouteList.forEach(registerRoute);
      return;
    }

    BaseRoute moduleRootRoute = finalRouteList.removeAt(moduleRootRouteIndex);

    var submoduleRoutes = getSubmoduleRoutes();

    if (moduleRootRoute is WidgetRoute) {
      moduleRootRoute.routes.addAll(submoduleRoutes);
    }

    // if (moduleRootRoute is NestedRoute) {
    //   moduleRootRoute.nestedRoutes.addAll(submoduleRoutes);
    // }

    finalRouteList.insert(moduleRootRouteIndex, moduleRootRoute);

    finalRouteList.forEach(registerRoute);
  }

  Iterable<BaseRoute> getSubmoduleRoutes() {
    return submodules.expand((element) => element.routes());
  }

  /// Register routes from the current [Module]
  /// This can be used to conditionally register routes from the [boot] method.
  void registerRoute(BaseRoute route) {
    // _validateRouteName(route.path);
    //
    // if (shouldNamespaceRoutes) {
    //   route = '/$name$route';
    //   if (route.endsWith('/')) {
    //     route = route.substring(0, route.length - 1);
    //   }
    // }

    AppRouter.registerRoute(route);
  }

  void _validateRouteName(String route) {
    throwIf(
      !route.startsWith('/'),
      ArgumentError.value(
        route,
        'Route',
        "Should begin with '/' in module $name",
      ),
    );
  }
}
