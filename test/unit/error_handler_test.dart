import 'package:flrx/components/error/error.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_error_reporter.dart';
import '../mocks/mock_logger.dart';

void main() {
  MockLogger logger = MockLogger();
  MockErrorReporter errorReporter = MockErrorReporter();
  ErrorHandler handler;
  setUp(() {
    handler = ErrorHandler.init(reporter: errorReporter);
  });

  tearDown(ErrorHandler.dispose);

  test("error_handler_init", () {
    expect(handler.reporter, errorReporter);
    expect(handler, ErrorHandler.instance);
  });

  test("error_handler_run_app", () async {
    handler.runApp(() => logger.log("Test Message"));
    await untilCalled(logger.log(captureAny));
    verify(logger.log("Test Message")).called(1);
  });
}
