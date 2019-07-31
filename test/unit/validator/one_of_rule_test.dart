import 'package:flrx/utils/validator/rules/one_of_rule.dart';
import 'package:test_api/test_api.dart';

void main() {
  String entityName = "oneOf";
  String validString = "test1";
  String invalidString = "fail";

  OneOfRule<String> rule = OneOfRule<String>(['test1', 'test2']);

  test("valid_one_of_test", () {
    String validationError = rule.validate(entityName, validString);
    expect(validationError, null);
  });

  test("invalid_one_of_test", () {
    String validationError = rule.validate(entityName, invalidString);
    expect(validationError, "$entityName is not in list of accepted values");
  });
}
