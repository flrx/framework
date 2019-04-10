abstract class ErrorReporter {
  bool reportOnDebug = false;

  void reportError(dynamic error, StackTrace stackTrace);
}
