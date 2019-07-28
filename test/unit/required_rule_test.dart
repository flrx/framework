import 'package:flrx/utils/validator/min_length_rule.dart';
import 'package:flrx/utils/validator/required_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  RequiredRule rule = RequiredRule();
  String validString = "12";
  String invalidString = "";
  var entityName = "required";
  test("valid_require_rule_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });
  test("invalid_require_rule_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError, '$entityName should not be empty!');
  });
}
