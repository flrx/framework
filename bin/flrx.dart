import 'dart:io';

import 'package:args/args.dart';

import 'commands/base_command.dart';
import 'commands/help_command.dart';
import 'module_generator.dart';

ArgResults results;

void main(List<String> arguments) {
  exitCode = 0;
  final parser = new ArgParser();
  List<Command> registerCommands = <Command>[
    HelpCommand(parser),
    ModuleGenerator(parser)
  ];

  registerCommands.forEach((Command c) {
    parser.addOption(c.name, abbr: c.abbr, help: c.help);
  });
  results = parser.parse(arguments);
  registerCommands.forEach((Command c) {
    if (results.wasParsed(c.name)) c.handler(results);
  });
}
