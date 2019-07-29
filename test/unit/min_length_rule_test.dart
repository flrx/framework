import 'package:flrx/utils/validator/rules/min_length_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  String entityName = "minLength";
  int minLength = 5;
  String validString = "12345";
  String invalidString = "12";

  MinLengthRule rule = MinLengthRule(minLength);

  test("valid_min_length_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });

  test("invalid_min_length_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError,
        "$entityName should be less than $minLength characters");
  });
}
