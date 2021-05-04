import 'package:flrx/flrx.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('flavored_app_shows_banner', (WidgetTester tester) async {
    var flavorName = 'test flavor';
    FlavorConfig(flavor: Flavor(flavorName), configList: <Config>[]);
    await tester.pumpWidget(FlavoredApp(
      showBanner: true,
      child: Container(),
    ));
    var bannerFinder = find.byType(Banner);
    expect(bannerFinder, findsOneWidget);
  });

  testWidgets('flavored_app_shows_no_banner', (WidgetTester tester) async {
    var flavorName = 'test flavor';
    FlavorConfig(flavor: Flavor(flavorName), configList: <Config>[]);
    await tester.pumpWidget(FlavoredApp(
      showBanner: false,
      child: Container(),
    ));
    var bannerFinder = find.byType(Banner);
    expect(bannerFinder, findsNothing);
  });
}
