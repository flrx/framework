import 'package:test_api/test_api.dart';

import '../../mocks/mock_validator_rule.dart';

void main() {
  String validationMessage = "Custom Validation";
  MockRule rule = MockRule(validationMessage: validationMessage);
  test('rule_uses_custom_validation_message', () {
    expect(rule.validate('entity', 'value'), validationMessage);
  });
}
