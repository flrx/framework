import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils/application_utils.dart';

class MakePageCommand extends Command {
  final String description = "Create a new Page";

  final String name = "make:page";

  MakePageCommand() {
    argParser
      ..addOption(
        "module",
        abbr: 'm',
        help: "Create page in specific module",
      );
    // ..addOption(
    //   "state",
    //   abbr: 's',
    //   help: "State to use for ViewModel and page",
    // );
  }

  @override
  FutureOr run() {
    String module = argResults['module'];
    String pageName = argResults.rest.single;
    String viewModelName = argResults.rest.single + "VM";
    if (module != null) {
      String path = "lib/modules/$module/pages/";
      createPage(path, pageName, viewModelName);
    } else {
      String path = "lib/pages/";
      createPage(path, pageName, viewModelName);
    }
    return 0;
  }

  void createPage(String path, String pageName, String viewModelName) {
    Directory(path).createSync(recursive: true);
    String sourceDirectory = ApplicationUtils.getScriptDirectory();
    File statelessPageStubFile =
        File(sourceDirectory + "/stubs/pages/stateless_page.stub");
    statelessPageStubFile.copySync(path + pageName + ".dart");
  }
}
