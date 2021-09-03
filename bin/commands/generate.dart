import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../utils/module_parser.dart';

class GenerateCommand extends Command with ModuleParser {
  @override
  final String description = 'Generate all Assets';

  @override
  final String name = 'gen';

  GenerateCommand() {
    //
  }

  @override
  FutureOr run() async {
    var splashGen = await Process.start(
      'flutter',
      [
        'pub',
        'run',
        'flutter_native_splash:create',
        '--path=flrx.yaml',
      ],
    );
    if (await splashGen.exitCode != 0) {
      return splashGen.exitCode;
    }

    var iconsGen = await Process.start(
      'flutter',
      [
        'pub',
        'run',
        'flutter_launcher_icons:main',
        '-f',
        'flrx.yaml',
      ],
    );
    if (await iconsGen.exitCode != 0) {
      return iconsGen.exitCode;
    }

    var envGen = await Process.start(
      'define_env',
      [
        '--no-print',
        '-f',
        '.env',
        '-s',
        'flrx.yaml',
      ],
    );
    if (await envGen.exitCode != 0) {
      return envGen.exitCode;
    }
  }
}
