import 'dart:io';

import 'package:meta/meta.dart';

import 'application_utils.dart';

class StubUtils {
  static void generateFileFromStub(
      {@required String stubPath,
      @required String destPath,
      @required Map<String, String> stubReplacements}) {
    createDirectory(File(destPath + ".dart").parent.path);
    String sourceDirectory = ApplicationUtils.getScriptDirectory();

    File stubFile = File("$sourceDirectory$stubPath.stub");
    String newFileContent = stubFile.readAsStringSync();

    File newFile = File("$destPath.dart")..createSync();
    newFileContent = _stubReplace(newFileContent, stubReplacements);

    newFile.writeAsStringSync(newFileContent);
  }

  static void createDirectory(String path) {
    Directory directoryPath = Directory(path);
    if (!directoryPath.existsSync()) {
      directoryPath.createSync(recursive: true);
    }
  }

  static String _stubReplace(
      String stubToReplace, Map<String, String> replacementMap) {
    replacementMap.forEach((String key, String value) {
      String keyToReplace = '%$key%';
      stubToReplace = stubToReplace.replaceAll(RegExp(keyToReplace), value);
    });
    return stubToReplace;
  }
}
