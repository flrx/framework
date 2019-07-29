import 'package:flrx/utils/validator/rule.dart';

class MockRule extends Rule {
  @override
  String validate(String entityName, String value) => value;
}

class MockAlwaysFailRule extends Rule {
  @override
  String validate(String entityName, String value) {
    return "$value is not a valid value for $entityName";
  }
}
