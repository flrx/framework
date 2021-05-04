import 'package:flrx/application.dart';
import 'package:flrx/components/error/error.dart';
import 'package:flrx/components/logger/base_logger.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.mocks.dart';

void main() {
  var logger = MockLogger();
  var errorReporter = MockErrorReporter();
  late ErrorHandler handler;

  setUpAll(() {
    Application.serviceLocator.registerSingleton<Logger>(logger);
  });

  setUp(() {
    handler = ErrorHandler.init(reporter: errorReporter);
  });

  tearDown(ErrorHandler.dispose);

  test('error_handler_init', () {
    expect(handler.reporter, errorReporter);
    expect(handler, ErrorHandler.instance);
  });

  test('error_handler_run_app', () async {
    await handler.runApp(() async => logger.log('Test Message'));
    verify(logger.log('Test Message')).called(1);
  });
}
