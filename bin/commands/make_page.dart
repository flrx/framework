import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';

import '../utils/application_utils.dart';
import '../utils/module_parser.dart';
import '../utils/stub_utils.dart';

class MakePageCommand extends Command with ModuleParser {
  @override
  final String description = 'Create a new Page';

  @override
  final String name = 'make:page';

  MakePageCommand() {
    addModuleOption(argParser, 'page');
    argParser.addOption(
      'state',
      abbr: 's',
      help: 'State to use for ViewModel and Page (optional)',
    );
  }

  String get pageName => argResults!.rest.single;

  String get viewModelName => '${pageName}VM';

  String get stateName =>
      argResults!['state'] ??
      (moduleName == null
          ? 'AppState'
          : '${ReCase(moduleName!).pascalCase}AppState');

  String get path =>
      moduleName == null ? 'lib/pages/' : 'lib/$modulePath/pages/';

  @override
  FutureOr run() {
    createPage();
    createViewModel();
    return 0;
  }

  void createPage() async {
    var pageFileName = ReCase(pageName).snakeCase;

    StubUtils.generateFileFromStub(
        stubPath: '/stubs/pages/stateless_page',
        destPath: path + pageFileName,
        stubReplacements: <String, String>{
          'SRC_PATH': (await ApplicationUtils.getName())+ modulePath,
          'VIEWMODEL_FILENAME': '${ReCase(pageName).snakeCase}_vm',
          'VIEWMODEL_NAME': viewModelName,
          'PAGE_NAME': pageName,
          'STATE_FILENAME': ReCase(stateName).snakeCase,
          'STATE': stateName,
        });
  }

  void createViewModel() async {
    var viewModelPath = '${path}viewmodels/${ReCase(pageName).snakeCase}_vm';

    StubUtils.generateFileFromStub(
        stubPath: '/stubs/pages/viewmodels/stateless_page_vm',
        destPath: viewModelPath,
        stubReplacements: <String, String>{
          'SRC_PATH': (await ApplicationUtils.getName())+ modulePath,
          'VIEWMODEL_NAME': viewModelName,
          'STATE_FILENAME': ReCase(stateName).snakeCase,
          'STATE': stateName,
        });
  }
}
