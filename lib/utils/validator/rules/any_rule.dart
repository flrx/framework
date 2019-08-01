import 'package:flrx/utils/validator/rule.dart';

class AnyRule<T> extends Rule<T> {
  final List<Rule<T>> _ruleList;

  AnyRule(this._ruleList, {String validationMessage})
      : super(validationMessage);

  @override
  String onValidate(String entityName, T value) {
    String ruleValidationMessage;
    _ruleList.reversed.any((Rule<T> rule) {
      ruleValidationMessage = rule.validate(entityName, value);
      return ruleValidationMessage == null;
    });
    return ruleValidationMessage;
  }
}
