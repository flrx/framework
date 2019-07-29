import 'package:flrx/utils/validator/rules/any_rule.dart';
import 'package:flrx/utils/validator/rules/one_of_rule.dart';
import 'package:flrx/utils/validator/validator.dart';
import 'package:test_api/test_api.dart';

import '../mocks/mock_validator_rule.dart';

void main() {
  MockRule mockRule = MockRule();
  Validator validator;

  setUp(() {
    validator = Validator();
  });



  test('test_validation_has_all_added_rules', () {
    validator.add(mockRule);
    expect(validator.rulesList.length, 1);
    validator.addAll([
      AnyRule([]),
      OneOfRule([]),
    ]);
    expect(validator.rulesList.length, 3);
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
