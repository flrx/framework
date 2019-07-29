import 'package:flrx/utils/validator/rule.dart';

class AnyRule<T> extends Rule<T> {
  final List<Rule<T>> _ruleList;
  final String validationMessage;

  AnyRule(this._ruleList, {this.validationMessage});

  @override
  String validate(String entityName, T value) {
    List<String> validationMessages = List();
    for (Rule rule in _ruleList) {
      String currentValidation = rule.validate(entityName, value);
      if (currentValidation == null) {
        return currentValidation;
      }
      validationMessages.add(currentValidation);
    }
    return validationMessage ?? validationMessages[0];
  }
}
