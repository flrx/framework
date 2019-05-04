import 'dart:io';

import 'package:args/args.dart';
import 'package:args/src/arg_parser.dart';

import 'commands/base_command.dart';

class ModuleGenerator extends Command {
  ModuleGenerator(ArgParser argParser) : super(argParser);

  @override
  String get abbr => 'm';

  @override
  int handler(ArgResults results) {
    print("Create new module '${results[name]}'?");
    Directory directory =
        Directory("lib${separator}modules$separator${results[name]}");
    directory.createSync(recursive: true);
    return 0;
  }

  @override
  String get help => 'Creates a new Module';

  @override
  String get name => 'module';
}
