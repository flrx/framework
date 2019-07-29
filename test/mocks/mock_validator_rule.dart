import 'package:flrx/utils/validator/rule.dart';

class MockRule extends Rule<String> {
  @override
  String validate(String entityName, String value) => value;
}

class MockAlwaysFailRule extends Rule<dynamic> {
  @override
  String validate(String entityName, dynamic value) {
    return "$value is not a valid value for $entityName";
  }
}
