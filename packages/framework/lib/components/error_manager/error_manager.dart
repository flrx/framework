import 'package:flutter/foundation.dart';

abstract class ErrorManager {
  ErrorManager();

  Future<void> init(AsyncCallback runAppFunction);

  void reportCheckedError(dynamic error, dynamic stackTrace);
}
