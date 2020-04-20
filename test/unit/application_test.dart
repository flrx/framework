import 'package:flrx/application.dart';
import 'package:flrx/components/error/error.dart';
import 'package:test/test.dart';

import '../mocks/mock_error_reporter.dart';
import '../mocks/mock_module.dart';

void main() {
  test("That Application can initalize Modules", () {
    Application.init(() {}, modules: [MockModule()]);

    ErrorReporter reporter = Application.get<ErrorReporter>();
    expect(reporter is MockErrorReporter, true);
  });
}
