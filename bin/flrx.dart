import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/make_module.dart';
import 'commands/make_page.dart';

ArgResults results;

void main(List<String> arguments) async {
  exitCode = 0;
  List<Command> registerCommands = <Command>[
    MakeModuleCommand(),
    MakePageCommand()
  ];
  CommandRunner runner = CommandRunner(
    "flrx",
    "flrx: An Opinionated Flutter Redux Framework",
  );
  registerCommands.forEach(runner.addCommand);
  runner.run(arguments);
}
