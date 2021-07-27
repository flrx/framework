// Mocks generated by Mockito 5.0.3 from annotations
// in flrx/test/mocks.dart.
// Do not manually edit this file.

import 'package:flrx/components/error/error_reporter.dart' as _i2;
import 'package:flrx/components/logger/base_logger.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [ErrorReporter].
///
/// See the documentation for Mockito's code generation for more information.
class MockErrorReporter extends _i1.Mock implements _i2.ErrorReporter {
  MockErrorReporter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void reportError(dynamic error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#reportError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [Logger].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogger extends _i1.Mock implements _i3.Logger {}