import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/list_routes.dart';
import 'commands/make_page.dart';
import 'commands/make_rule.dart';

ArgResults results;

void main(List<String> arguments) async {
  exitCode = 0;
  var registerCommands = <Command>[
    MakePageCommand(),
    MakeRuleCommand(),
    ListRoutesCommand(),
  ];
  var runner = CommandRunner(
    'flrx',
    'flrx: An Opinionated Flutter Redux Framework',
  );
  registerCommands.forEach(runner.addCommand);
  await runner.run(arguments);
}
