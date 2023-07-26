import 'package:flrx/flrx.dart' hide Page;
import 'package:flutter/material.dart';

class AppRouter {
  static AppRouter? __instance;

  final List<BaseRoute> _routes = [];

  RouteWidgetBuilder? _errorBuilder;

  static GlobalKey<NavigatorState> get navigatorKey =>
      _goRouter!.routerDelegate.navigatorKey;

  static AppRouter get _instance {
    __instance ??= AppRouter();

    return __instance!;
  }

  static void registerRoute(BaseRoute route) {
    _instance._routes.add(route);
  }

  static void _registerNotFoundHandler({required RouteWidgetBuilder builder}) =>
      _instance._errorBuilder = builder;

  /// Sets a default [RouteWidgetBuilder] when no route matches. Similar to a 404 Page.
  static void setNotFoundWidget(RouteWidgetBuilder builder) =>
      _registerNotFoundHandler(builder: builder);

  static GoRouter? _goRouter;

  static GoRouter get goRouter {
    _goRouter ??= GoRouter(
      routes: _buildGoRoutes(),

      /// Replace this after (https://github.com/flutter/flutter/issues/99126) gets fixed
      /// We should be using ShellRoute or something similar
      // navigatorBuilder: _createNavigatorBuilder,
      errorPageBuilder: _instance._errorBuilder == null
          ? null
          : createGoBuilderFromRouteWidgetBuilder(_instance._errorBuilder!),
    );

    return _goRouter!;
  }

  static RouteInformationParser<Object> get routeInformationParser =>
      goRouter.routeInformationParser;

  static RouterDelegate<Object> get routerDelegate => goRouter.routerDelegate;

  // static Widget _createNavigatorBuilder(context, state, child) {
  //   String namespace = getNamespaceRouterState(state);
  //   if (namespace.isEmpty) {
  //     return child;
  //   }
  //
  //   var builder =
  //   _instance.rootWidgetBuilders.cast<RootWidgetBuilder?>().firstWhere(
  //         (element) => namespace.startsWith(element!.module.name),
  //     orElse: () => null,
  //   );
  //
  //   if (builder == null) {
  //     return child;
  //   }
  //
  //   return builder.rootWidgetBuilder(context, child);
  // }

  static String getNamespaceRouterState(GoRouterState state) {
    return state.uri.toString().substring(1);
  }

  static List<GoRoute> _buildGoRoutes() {
    return _instance._routes.map((route) => route.toGoRoute()).toList();
  }

  static Page Function(BuildContext, GoRouterState)
      createGoBuilderFromRouteWidgetBuilder(
    RouteWidgetBuilder builder,
  ) {
    return (context, state) {
      var pathParams = state.pathParameters;
      var queryParams = state.uri.queryParameters;
      var params = pathParams.map((key, value) {
        return MapEntry(key, [value]);
      });
      queryParams.forEach((key, value) {
        params[key] ??= [value];
      });

      return MaterialPage(
        key: state.pageKey,
        child: builder(params),
      );
    };
  }

  static navigateTo(String path, {Object? extra}) {
    navigatorKey.currentContext!.go(path, extra: extra);
  }

// static List<VRouteElementBuilder> buildVRouterRoutes() {
//   return _instance._routes.map((route) => route.toVRoute()).toList()
//     ..add(
//       VWidget(
//         path: "*",
//         widget: _instance._errorBuilder!({}),
//       ),
//     )
//     ..forEach((element) {
//       printRoute('', element);
//     });
// }

// static void printRoute(String previousPath, VRouteElement route) {
//   String? routePath;
//   if (route is VWidget) {
//     routePath = route.path;
//   }
//
//   if (route is VNester) {
//     routePath = route.path;
//   }
//
//   var fullPath = routePath == null
//       ? previousPath
//       : routePath == '/'
//           ? '/'
//           : '$previousPath/$routePath';
//
//   print('${route.runtimeType}: $fullPath');
//
//   if (route is VWidget) {
//     route.stackedRoutes.forEach((r) => printRoute("  $fullPath", r));
//   }
//
//   if (route is VNester) {
//     route.nestedRoutes.forEach((r) => printRoute("  $fullPath", r));
//   }
// }
}

typedef RouteWidgetBuilder = Widget Function(Map<String, List<String>> params);
