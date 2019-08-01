import 'package:flrx/utils/validator/rule.dart';

class MaxLengthRule extends Rule<String> {
  final int maxLength;

  MaxLengthRule(this.maxLength, {String validationMessage})
      : super(validationMessage);

  @override
  String onValidate(String entityName, String value) {
    if (value.length <= maxLength) {
      return null;
    }
    return validationMessage ??
        "$entityName should be less than $maxLength characters";
  }
}
