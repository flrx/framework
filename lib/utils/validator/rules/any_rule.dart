import 'package:flrx/utils/validator/rule.dart';

class AnyRule extends Rule {
  final List<Rule> _ruleList;
  final String validationMessage;

  AnyRule(this._ruleList, {this.validationMessage});

  @override
  String validate(String entityName, String value) {
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
