import 'package:flrx/utils/validator/rule.dart';

class AnyRule<T> extends Rule<T> {
  final List<Rule<T>> _ruleList;
  final String validationMessage;

  AnyRule(this._ruleList, {this.validationMessage});

  @override
  String validate(String entityName, T value) {
    String ruleValidationMessage;
    _ruleList.reversed.any((Rule<T> rule) {
      ruleValidationMessage = rule.validate(entityName, value);
      return ruleValidationMessage == null;
    });
    return ruleValidationMessage == null
        ? ruleValidationMessage
        : (validationMessage ?? ruleValidationMessage);
  }
}
