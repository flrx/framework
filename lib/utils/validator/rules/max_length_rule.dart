import 'package:flrx/utils/validator/rule.dart';

class MaxLengthRule extends Rule<String> {
  final int maxLength;

  MaxLengthRule(this.maxLength);

  @override
  String validate(String entityName, String value) {
    if (value.length > maxLength) {
      return "$entityName should be less than $maxLength characters";
    }
    return null;
  }
}
