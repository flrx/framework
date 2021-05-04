import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/make_page.dart';
import 'commands/make_rule.dart';

void main(List<String> arguments) async {
  exitCode = 0;
  var registerCommands = <Command>[
    MakePageCommand(),
    MakeRuleCommand(),
  ];
  var runner = CommandRunner(
    'flrx',
    'flrx: An Opinionated Flutter Redux Framework',
  );
  registerCommands.forEach(runner.addCommand);
  await runner.run(arguments);
}
