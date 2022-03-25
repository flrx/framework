import 'package:flutter/foundation.dart';

export 'catcher_error_manager.dart';

abstract class ErrorManager {
  ErrorManager();

  Future<void> init(VoidCallback runAppFunction);

  void reportCheckedError(dynamic error, dynamic stackTrace);
}
