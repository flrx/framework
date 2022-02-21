import 'package:flrx/application.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_config.dart';
import '../mocks/mock_module.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('That Application can initialize Modules', () {
    var mockModule = MockModule();

    Application(() async {}, appConfig: MockConfig([mockModule])).init();

    var instance = Application.get<RandomClass>();
    expect(instance is RandomClass, true);
  });
}
