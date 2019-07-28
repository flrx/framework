import 'package:flrx/utils/validator/min_length_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  int minLength = 5;

  MinLengthRule rule = MinLengthRule(minLength);
  String validString = "12345";
  String invalidString = "12";
  var entityName = "minLength";
  test("valid_min_length_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });
  test("invalid_min_length_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError,
        "$entityName should be more than $minLength characters");
  });
}
