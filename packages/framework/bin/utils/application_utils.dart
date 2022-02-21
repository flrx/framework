import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class ApplicationUtils {
  static Future<String> getName() async {
    var pubspecYamlFile = File('pubspec.yaml');
    var pubspecYamlStr = await pubspecYamlFile.readAsString();
    YamlMap pubspecYaml = loadYaml(pubspecYamlStr);

    return pubspecYaml['name'];
  }

  static String getScriptDirectory() {
    return dirname(Platform.script.toFilePath(windows: Platform.isWindows));
  }
}
