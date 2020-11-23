import 'package:flrx/components/modules/module.dart';
import 'package:flrx/flrx.dart';
import 'package:flutter/widgets.dart';

class TestModule extends Module {
  static const String MOCK_LOGIN = '/login';
  static const String MOCK_REGISTER = '/register';
  static const String MOCK_CUSTOMER_HOME = '/customer';
  static const String MOCK_CUSTOMER_PROFILE = '/customer/profile';

  @override
  String get name => 'test';

  @override
  bool get shouldNamespaceRoutes => false;

  @override
  Map<String, RouteWidgetBuilder> routes() {
    return <String, RouteWidgetBuilder>{
      MOCK_LOGIN: (args) => Container(),
      MOCK_REGISTER: (args) => Container(),
      MOCK_CUSTOMER_HOME: (args) => Container(),
      MOCK_CUSTOMER_PROFILE: (args) => Container(),
    };
  }
}
