import 'package:flrx/utils/validator/rule.dart';

class MinLengthRule extends Rule {
  final int minLength;

  MinLengthRule(this.minLength);

  @override
  String validate(String entityName, String value) {
    if (value.length < minLength) {
      return "$entityName should be less than $minLength characters";
    }
    return null;
  }
}
