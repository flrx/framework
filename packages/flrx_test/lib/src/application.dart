import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flrx/flrx.dart';
import 'package:flrx_test/src/error_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestApplication extends Application {
  final WidgetTester tester;

  TestApplication(
    AsyncValueGetter<Widget> initApp, {
    required this.tester,
    required ApplicationConfig config,
  }) : super(initApp, appConfig: config);

  @override
  Future<void> init() {
    /// Flutter Tests have to ensure that Error management is not changed
    /// So we do the following to initialize the app for test
    /// 1. Setup a [TestErrorManager]
    /// 2. Register the modules
    /// 3. Call the original method to run, which should return the widget
    /// 4. Validate the widget is received and pump it
    Application.serviceLocator
        .registerSingleton<ErrorManager>(TestErrorManager());

    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({}); //set values here

    return registerModules()
        .then((_) => initApp())
        .then((widget) => initiateTestSetup(widget));
  }

  Future<void> initiateTestSetup(widget) async {
    if (widget == null || widget is! Widget) {
      fail(
        'Test App Initialization failed.\n'
        'initApp should return a Widget for tests',
      );
    }

    return tester.pumpWidget(widget);
  }
}
