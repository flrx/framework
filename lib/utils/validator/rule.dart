import 'package:flrx/utils/string_utils.dart';
import 'package:meta/meta.dart';

abstract class Rule<T> {
  Rule(this.validationMessage);

  final String validationMessage;

  @visibleForOverriding
  String validate(String entityName, T value) {
    String validationMessageFromRule = onValidate(entityName, value);
    if (validationMessageFromRule == null) {
      return null;
    }
    return replaceParamsFromMessage(
        validationMessage ?? validationMessageFromRule, entityName, value);
  }

  @protected
  String onValidate(String entityName, T value);

  String replaceParamsFromMessage(String message, String entityName, T value) {
    return StringUtils.replaceWithValues(message, {
      'entity': entityName,
      'value': value.toString(),
    });
  }
}
