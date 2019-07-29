import 'package:flrx/utils/validator/rules/max_length_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  String entityName = "maxLength";
  int maxLength = 5;
  String validString = "12345";
  String invalidString = "12345678";

  MaxLengthRule rule = MaxLengthRule(maxLength);

  test("valid_max_length_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });

  test("invalid_max_length_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError,
        "$entityName should be more than $maxLength characters");
  });
}
