import 'package:flrx/flrx.dart';
// import 'package:vrouter/vrouter.dart';

abstract class BaseRoute {
  final String? path;

  BaseRoute(this.path);

  RouteBase toGoRoute();
  // VRouteElementBuilder toVRoute();
}
