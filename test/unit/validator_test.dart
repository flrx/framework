import 'package:flrx/utils/validator/validator.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_validator_rule.dart';

void main() {
  MockRule mockRule = MockRule();
  Validator validator;

  setUpAll(() {
    validator = Validator();
  });

  test('test_validation_rule_passes', () {
    Function validationFunction = validator.add(mockRule).build();
    String validationMessage = validationFunction(null);
    expect(validationMessage, null);
  });

  test('test_validation_rule_fails', () {
    Function validationFunction = validator.add(mockRule).build();
    String validationMessage = validationFunction("Fail");
    expect(validationMessage, "Fail");
  });
}
