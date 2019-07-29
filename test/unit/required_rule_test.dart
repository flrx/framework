import 'package:flrx/utils/validator/rules/required_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  String entityName = "required";
  String validString = "12";
  String invalidString = "";

  RequiredRule rule = RequiredRule();

  test("valid_require_rule_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });

  test("invalid_require_rule_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError, '$entityName should not be empty!');
  });
}