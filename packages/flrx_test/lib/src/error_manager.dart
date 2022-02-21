import 'dart:ui';

import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flutter/foundation.dart';

class TestErrorManager extends ErrorManager {
  TestErrorManager() : super();

  @override
  void init(VoidCallback runAppFunction) => runAppFunction();

  @override
  void reportCheckedError(error, stackTrace) {
    // FlutterError.presentError()
    // TODO: implement reportCheckedError
  }
}
