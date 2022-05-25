import 'package:flrx/navigation/base_route.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:vrouter/vrouter.dart';

class NestedRoute extends BaseRoute {
  final Widget Function(Widget child) widgetBuilder;
  final List<BaseRoute> nestedRoutes;

  NestedRoute({
    required String? path,
    required this.widgetBuilder,
    required this.nestedRoutes,
  }) : super(path);

  @override
  GoRoute toGoRoute() {
    return GoRoute(
      path: path ?? '',
      routes: nestedRoutes.map((route) => route.toGoRoute()).toList(),
      builder: (context, state) {
        // TODO: implement toGoRoute
        // return widgetBuilder(child);
        throw UnimplementedError();
      },
    );
  }

  @override
  VRouteElementBuilder toVRoute() {
    return VNester(
      path: path,
      widgetBuilder: widgetBuilder,
      nestedRoutes: nestedRoutes.map((e) => e.toVRoute()).toList(),
    );
  }
}
