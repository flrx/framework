import 'package:flrx/utils/validator/rules/regex_rule.dart';

class EmailRule extends RegexRule {
  static const String emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

  EmailRule() : super(emailRegex);

  @override
  String validate(String entityName, value) {
    if (value.isEmpty) {
      return '$entityName should not be empty!';
    }

    String validationMessage = super.validate(entityName, value);

    if (validationMessage != null) {
      validationMessage = "$value is not a valid email address";
    }

    return validationMessage;
  }
}
