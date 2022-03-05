// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:{{name}}/config/app_config.dart';
import 'package:{{name}}/main.dart' as app;
import 'package:flrx_test/flrx_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> setupApp(WidgetTester tester) async {
    await TestApplication(
      app.initAppWidget,
      tester: tester,
      config: AppConfig(),
    ).init();
  }

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Setup App
    await setupApp(tester);

    await tester.pump();

    expectNoErrorWidget();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

/// This should happen automatically.
/// We shouldn't need to test for this
void expectNoErrorWidget() {
  var errorWidget = find.byType(ErrorWidget).evaluate();
  if (errorWidget.isNotEmpty) {
    fail(errorWidget.first.widget.toString());
  }
}
