import 'package:flutter/widgets.dart';

class WidgetRoute {
  final Widget Function(Map<String, List<String>> params) builder;

  WidgetRoute(this.builder);
}
