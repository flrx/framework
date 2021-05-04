import 'package:flrx/config/base_config.dart';
import 'package:flrx/config/flavors/flavor.dart';

class FlavorConfig {
  factory FlavorConfig({
    required BaseFlavor flavor,
    required List<Config> configList,
  }) {
    _instance ??= FlavorConfig._internal(flavor, configList);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, List<Config> configList) {
    this.configList = configList.map((Config config) {
      return config.of(flavor as Flavor);
    }).toList();
  }

  final BaseFlavor flavor;
  List<Config> configList = <Config>[];

  static FlavorConfig? _instance;

  static FlavorConfig? get instance => _instance;

  static String get name => _instance!.flavor.toString();
}
