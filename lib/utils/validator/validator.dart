import 'package:flrx/utils/validator/rule.dart';

class Validator {

  Validator({this.entityName = "Entity"});

  String entityName;

  /// List of all registered rules
  List<Rule> rulesList = [];

  Validator add(Rule rule) {
    rulesList.add(rule);
    return this;
  }

  String Function(String) run() => _run;

  String _run(String value) {
    String validationMessage;
    for (Rule rule in rulesList) {
      validationMessage = rule.validate(entityName, value);
      if (validationMessage?.isNotEmpty == true) {
        return validationMessage;
      }
    }
    return validationMessage;
  }

}
