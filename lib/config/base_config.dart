import 'package:flrx/config/flavors/flavor_config.dart';
import 'package:flrx/flrx.dart';

abstract class Config {
  static bool get isInDebugMode {
    var inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  Config();

  Config of(Flavor flavor);

  static T get<T extends Config>() {
    return FlavorConfig.instance!.configList.firstWhere(
        (Config config) => config is T,
        orElse: (() =>
            throw Exception('Config $T is not registered in ConfigList'))) as T;
  }
}
