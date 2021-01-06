import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

class ListRoutesCommand extends Command {
  @override
  final String description = 'List all routes registered by modules';

  @override
  final String name = 'route:list';

  ListRoutesCommand() {
    argParser.addOption(
      'file',
      abbr: 'f',
      help: 'File to use where modules are registered',
    );
  }

  @override
  FutureOr run() async {
    var filePath = argResults['file'].toString();
    var file = File.fromUri(Uri.parse(filePath));
    var newFilePath =
        '${filePath.substring(0, filePath.indexOf('.dart'))}_routes.dart';

    var newFile = file.copySync(newFilePath);
    newFile.openWrite(mode: FileMode.append).write('''       

void printRoutes() {
  AppRouter.printRegisteredRoutes();
}

''');
    return 0;
  }
}
