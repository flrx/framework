import 'package:flrx/flrx.dart';
import 'package:flrx/navigation/base_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
// import 'package:vrouter/vrouter.dart';

class WidgetRoute extends BaseRoute {
  final Widget Function(
    Map<String, String> pathParams,
    Map<String, String> queryParams,
  ) widgetBuilder;

  final List<BaseRoute> routes;

  WidgetRoute({
    required String? path,
    required this.widgetBuilder,
    this.routes = const [],
  }) : super(path);

  @override
  GoRoute toGoRoute() {
    return GoRoute(
      path: path ?? '',
      builder: (context, state) =>
          widgetBuilder(state.params, state.queryParams),
      routes: routes.map((route) => route.toGoRoute()).toList(),
    );
  }

// @override
// VRouteElementBuilder toVRoute() {
//   return VWidget(
//     path: path,
//     widget: Builder(builder: (context) {
//       return widgetBuilder(
//         context.vRouter.pathParameters,
//         context.vRouter.queryParameters,
//       );
//     }),
//     stackedRoutes: routes.map((route) => route.toVRoute()).toList(),
//   );
// }
}
