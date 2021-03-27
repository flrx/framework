import 'package:flrx/config/base_config.dart';
import 'package:flrx/config/config_error.dart';
import 'package:flrx/config/flavors/flavor.dart';
import 'package:meta/meta.dart';

class FlavorConfig {
  factory FlavorConfig(
      {@required BaseFlavor flavor, @required List<Config> configList}) {
    _instance ??= FlavorConfig._internal(flavor, configList);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, List<Config> configList) {
    this.configList = configList.map((Config config) {
      var flavoredConfig = config.of(flavor);
      if (flavoredConfig == null) {
        throw ConfigNotImplementedError(
            configType: runtimeType.toString(), flavor: flavor);
      }
      return flavoredConfig;
    }).toList();
  }

  final BaseFlavor flavor;
  List<Config> configList = <Config>[];

  static FlavorConfig _instance;

  static FlavorConfig get instance => _instance;

  static String get name => _instance.flavor.toString();
}
