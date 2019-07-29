
import 'package:flrx/utils/validator/rule.dart';
import 'package:flutter/widgets.dart';

/// A utility class primarily designed to be used by [FormField]'s validator.
///
/// The [Validator] class takes a List of [Rule]. The value supplied to the
/// [Validator] is supplied to the [Rule]s in the order they were registered.
/// The error message of the first [Rule] that fails is returned back.
/// If all the [Rule]s pass, then null is returned to the [FormField].
class Validator {

  Validator({this.entityName = "Entity"});

  /// The name of the field that is being evaluated.
  ///
  /// The [Validator.entityName] property is used by some [Rule]s to format their
  /// Error Message.
  String entityName;

  /// List of all registered rules.
  List<Rule> rulesList = [];

  /// Registers a single [Rule] with the [Validator].
  Validator add(Rule rule) {
    rulesList.add(rule);
    return this;
  }

  /// Registers a List of [Rule] with the [Validator].
  Validator addAll(List<Rule> rule) {
    rulesList.addAll(rule);
    return this;
  }

  /// Returns a [FormFieldValidator] to be used with a [FormField].
  FormFieldValidator<String> build() => validate;

  /// Validates and returns an error message(if any).
  String validate(String value) {
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
