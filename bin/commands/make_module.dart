import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:path/path.dart' as pathLib;

var separator = pathLib.separator;

class MakeModuleCommand extends Command {
  final String name = 'make:module';
  final String description = 'Generate new Files';

  @override
  FutureOr run() {
    List<String> modulesToCreate = argResults.rest;
    modulesToCreate.forEach(createSingleModule);
    return 0;
  }

  void createSingleModule(String moduleName) {
    print("Creating new module '$moduleName'");
    Directory directory =
        Directory("lib${separator}modules$separator$moduleName");
    directory.createSync(recursive: true);
  }
}
