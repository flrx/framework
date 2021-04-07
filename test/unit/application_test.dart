import 'package:flrx/application.dart';
import 'package:flrx/components/error/error.dart';
import 'package:test/test.dart';

import '../mocks.mocks.dart';
import '../mocks/mock_module.dart';

void main() {
  test('That Application can initialize Modules', () {
    var mockModule = MockModule();

    Application.init(() async {}, modules: [mockModule]);

    var reporter = Application.get<ErrorReporter>();
    expect(reporter is MockErrorReporter, true);
  });
}
