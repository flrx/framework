import 'package:flrx/application.dart';
import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/mock_error_reporter.dart';
import '../mocks/mock_logger.dart';

void main() {
  var reporter = MockErrorReporter();
  var testException = Exception('Test Exception');
  var flutterError = FlutterError('Test Flutter Error');
  Function exceptionBlock = () => throw testException;
  Function flutterErrorBlock = () => throw flutterError;
  var logger = MockLogger();
  Application.serviceLocator.registerSingleton<Logger>(logger);

  group('error_reporter', () {
    setUp(() {
      reporter = MockErrorReporter();
      reset(reporter);
      reset(logger);
    });

    tearDown(ErrorHandler.dispose);

    test('test_catch_exception_debug_mode_reporting', () async {
      reporter.reportOnDebug = true;
      ErrorHandler.init(reporter: reporter).runApp(exceptionBlock);
      await untilCalled(reporter.reportError(captureAny, captureAny));
      verify(reporter.reportError(testException, captureAny)).called(1);
      verifyZeroInteractions(logger);
    });

    /// This is not a reliable test
    test('test_catch_exception_disabled_debug_mode_reporting', () async {
      reporter.reportOnDebug = false;
      ErrorHandler.init(reporter: reporter).runApp(exceptionBlock);
      await untilCalled(logger.log(captureAny));
      verify(logger.log(captureAny)).called(greaterThanOrEqualTo(1));
      verifyZeroInteractions(reporter);
    });

    test('test_catch_flutter_error_debug_mode_reporting', () async {
      reporter.reportOnDebug = true;
      ErrorHandler.init(reporter: reporter).runApp(flutterErrorBlock);
      await untilCalled(reporter.reportError(captureAny, captureAny));
      verify(reporter.reportError(flutterError, captureAny)).called(1);
      verifyZeroInteractions(logger);
    });
  });
}
