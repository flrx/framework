import 'package:flrx/components/modules/module.dart';
import 'package:flrx/config/application_config.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';

class MockConfig extends ApplicationConfig {
  final List<Module> _modules;

  MockConfig(this._modules);

  @override
  List<Module> get modules => _modules;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
