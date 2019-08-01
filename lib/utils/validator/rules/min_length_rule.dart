import 'package:flrx/utils/validator/rule.dart';

class MinLengthRule extends Rule<String> {
  final int minLength;

  MinLengthRule(this.minLength, {String validationMessage})
      : super(validationMessage);

  @override
  String onValidate(String entityName, String value) {
    if (value.length < minLength) {
      return "$entityName should be more than $minLength characters";
    }
    return null;
  }
}
