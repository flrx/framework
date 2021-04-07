import 'package:flrx/application.dart';
import 'package:flrx/components/error/error_handler.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.mocks.dart';

void main() {
  var reporter = MockErrorReporter();
  var testException = Exception('Test Exception');
  var flutterError = FlutterError('Test Flutter Error');
  var exceptionBlock = () => throw testException;
  var flutterErrorBlock = () => throw flutterError;
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
      await ErrorHandler.init(reporter: reporter, reportErrorOnDebug: true)
          .runApp(exceptionBlock);
      verify(reporter.reportError(testException, any)).called(1);
      verifyZeroInteractions(logger);
    });

    /// This is not a reliable test
    test('test_catch_exception_disabled_debug_mode_reporting', () async {
      await ErrorHandler.init(reporter: reporter).runApp(exceptionBlock);
      await untilCalled(logger.log(any));
      verify(logger.log(any)).called(greaterThanOrEqualTo(1));
      verifyZeroInteractions(reporter);
    });

    test('test_catch_flutter_error_debug_mode_reporting', () async {
      await ErrorHandler.init(reporter: reporter, reportErrorOnDebug: true)
          .runApp(flutterErrorBlock);
      verify(reporter.reportError(flutterError, any)).called(1);
      verifyZeroInteractions(logger);
    });
  });
}
