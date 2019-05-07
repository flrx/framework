import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';

import '../utils/application_utils.dart';
import '../utils/stub_utils.dart';

class MakePageCommand extends Command {
  final String description = "Create a new Page";

  final String name = "make:page";

  MakePageCommand() {
    argParser
      ..addOption(
        "module",
        abbr: 'm',
        help: "Create page in specific module (optional)",
      )
      ..addOption(
        "state",
        abbr: 's',
        help: "State to use for ViewModel and Page (optional)",
      );
  }

  String get pageName => argResults.rest.single;

  String get moduleName => argResults['module'].toLowerCase();

  String get viewModelName => pageName + 'VM';

  String get stateName =>
      argResults['state'] ??
      (moduleName == null
          ? 'AppState'
          : '${ReCase(moduleName).pascalCase}AppState');

  String get modulePath => moduleName == null ? '' : "/modules/$moduleName";

  String get path =>
      moduleName == null ? 'lib/pages/' : "lib/$modulePath/pages/";

  @override
  FutureOr run() {
    createPage();
    createViewModel();
    return 0;
  }

  void createPage() async {
    String pageFileName = ReCase(pageName).snakeCase;

    StubUtils.generateFileFromStub(
        stubPath: "/stubs/pages/stateless_page",
        destPath: path + pageFileName,
        stubReplacements: <String, String>{
          "SRC_PATH": (await ApplicationUtils.getName()) + modulePath,
          "VIEWMODEL_FILENAME": "${ReCase(pageName).snakeCase}_vm",
          "VIEWMODEL_NAME": viewModelName,
          "PAGE_NAME": pageName,
          "STATE_FILENAME": ReCase(stateName).snakeCase,
          "STATE": stateName,
        });
  }

  void createViewModel() async {
    String viewModelPath = "${path}viewmodels/${ReCase(pageName).snakeCase}_vm";

    StubUtils.generateFileFromStub(
        stubPath: "/stubs/pages/viewmodels/stateless_page_vm",
        destPath: viewModelPath,
        stubReplacements: <String, String>{
          "SRC_PATH": (await ApplicationUtils.getName()) + modulePath,
          "VIEWMODEL_NAME": viewModelName,
          "STATE_FILENAME": ReCase(stateName).snakeCase,
          "STATE": stateName,
        });
  }
}
