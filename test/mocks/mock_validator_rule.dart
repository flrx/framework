import 'package:flrx/utils/validator/rule.dart';

class MockRule extends Rule<String> {
  MockRule({String validationMessage}) : super(validationMessage);

  @override
  String onValidate(String entityName, String value) => value;
}

class MockAlwaysFailRule extends Rule<dynamic> {
  MockAlwaysFailRule() : super(null);

  @override
  String onValidate(String entityName, dynamic value) {
    return "$value is not a valid value for $entityName";
  }
}
