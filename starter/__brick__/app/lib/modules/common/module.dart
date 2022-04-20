import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:{{name}}/modules/common/pages/counter_page.dart';

class CommonModule extends Module {
  @override
  String get name => 'common';

  @override
  bool get shouldNamespaceRoutes => false;

  @override
  Future<void> register() async {
    locator.registerSingleton<Logger>(Logger());
  }

  @override
  Map<String, RouteWidgetBuilder> routes() {
    return {
      '/': (args) => const CounterPage(),
    };
  }
}
