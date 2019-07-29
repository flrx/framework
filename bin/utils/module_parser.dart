import 'package:args/args.dart';

mixin ModuleParser {
  ArgResults get argResults;

  String get moduleName => argResults['module']?.toLowerCase();

  String get modulePath => moduleName == null ? '' : "/modules/$moduleName";

  void addModuleOption(ArgParser argParser,String name) {
    argParser
      ..addOption(
        "module",
        abbr: 'm',
        help: "Create $name in specific module (optional)",
      );
  }
}
