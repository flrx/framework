import 'package:flrx/utils/validator/rule.dart';

class RequiredRule extends Rule {
  @override
  String validate(String entityName, String value) {
    if (value.isEmpty) {
      return '$entityName should not be empty!';
    }
    return null;
  }
}
