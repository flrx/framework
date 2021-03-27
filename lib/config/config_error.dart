import 'package:flrx/config/flavors/flavor.dart';
import 'package:meta/meta.dart';

class ConfigNotImplementedError extends UnimplementedError {
  ConfigNotImplementedError({@required this.configType, @required this.flavor});

  String configType;
  BaseFlavor flavor;

  @override
  String toString() =>
      'ConfigNotImplementedError: $configType Has not been implemented for $flavor';
}
