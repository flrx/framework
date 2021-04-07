import 'dart:io';

import 'application_utils.dart';

class StubUtils {
  static void generateFileFromStub({
    required String stubPath,
    required String destPath,
    required Map<String, String> stubReplacements,
  }) {
    createDirectory(File('$destPath.dart').parent.path);
    var sourceDirectory = ApplicationUtils.getScriptDirectory();

    var stubFile = File('$sourceDirectory$stubPath.stub');
    var newFileContent = stubFile.readAsStringSync();

    var newFile = File('$destPath.dart')..createSync();
    newFileContent = _stubReplace(newFileContent, stubReplacements);

    newFile.writeAsStringSync(newFileContent);
  }

  static void createDirectory(String path) {
    var directoryPath = Directory(path);
    if (!directoryPath.existsSync()) {
      directoryPath.createSync(recursive: true);
    }
  }

  static String _stubReplace(
      String stubToReplace, Map<String, String> replacementMap) {
    replacementMap.forEach((String key, String value) {
      var keyToReplace = '%$key%';
      stubToReplace = stubToReplace.replaceAll(RegExp(keyToReplace), value);
    });
    return stubToReplace;
  }
}
