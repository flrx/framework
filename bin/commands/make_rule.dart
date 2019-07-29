import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';

import '../utils/module_parser.dart';
import '../utils/stub_utils.dart';

class MakeRuleCommand extends Command with ModuleParser {
  final String description = "Create a new Input Validation Rule";

  final String name = "make:rule";

  MakeRuleCommand() {
    addModuleOption(argParser, 'rule');
  }

  String get ruleName => argResults.rest.single;

  String get path => moduleName == null
      ? 'lib/validator/rules/'
      : "lib/$modulePath/validator/rules/";

  @override
  FutureOr run() {
    createRule();
    return 0;
  }

  void createRule() async {
    String ruleFileName = ReCase(ruleName).snakeCase;

    StubUtils.generateFileFromStub(
        stubPath: "/stubs/validator/rule",
        destPath: path + ruleFileName,
        stubReplacements: <String, String>{
          "RULE_NAME": ruleName,
        });
  }
}
