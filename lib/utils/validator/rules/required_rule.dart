import 'package:flrx/utils/validator/rule.dart';

class RequiredRule extends Rule<String> {
  RequiredRule({String validationMessage}) : super(validationMessage);

  @override
  String onValidate(String entityName, String value) {
    if (value.isEmpty) {
      return '$entityName should not be empty!';
    }
    return null;
  }
}
