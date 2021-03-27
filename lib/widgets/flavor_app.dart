import 'package:flrx/config/base_config.dart';
import 'package:flrx/config/flavors/flavor_config.dart';
import 'package:flutter/widgets.dart';

class FlavoredApp extends StatelessWidget {
  FlavoredApp({@required this.child, this.showBanner = true, Key key})
      : super(key: key);

  final Widget child;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    if (showBanner && Config.isInDebugMode) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          key: Key('banner'),
          location: BannerLocation.topStart,
          message: FlavorConfig.name,
          child: child,
        ),
      );
    }
    return child;
  }
}
