import 'package:flrx/components/modules/module.dart';
import 'package:flrx/config/application_config.dart';

class MockConfig extends ApplicationConfig {
  final List<Module> _modules;

  MockConfig(this._modules);

  @override
  List<Module> get modules => _modules;
}
