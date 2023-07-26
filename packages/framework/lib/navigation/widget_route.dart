import 'package:flrx/flrx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetRoute extends BaseRoute {
  final Widget Function(
    Map<String, String> pathParams,
    Map<String, String> queryParams,
  ) widgetBuilder;

  List<BaseRoute> routes;

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
          widgetBuilder(state.pathParameters, state.uri.queryParameters),
      routes: routes.isNotEmpty
          ? routes.map((route) => route.toGoRoute()).toList(growable: true)
          : [],
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
