import 'package:flrx/utils/validator/rule.dart';

class MockRule extends Rule {
  @override
  String validate(String entityName, String value) => value;
}
