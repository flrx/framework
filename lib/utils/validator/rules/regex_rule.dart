import 'package:flrx/utils/validator/rule.dart';

class RegexRule extends Rule<String> {
  RegexRule(this.regex);

  final String regex;

  @override
  String validate(String entityName, value) {
    RegExp regExp = RegExp(regex);
    if (!regExp.hasMatch(value)) {
      return "$value is not a valid pattern";
    }
    return null;
  }
}
