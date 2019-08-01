import 'package:flrx/utils/validator/rule.dart';

class OneOfRule<T> extends Rule<T> {
  final List<T> acceptedList;

  OneOfRule(this.acceptedList, {String validationMessage})
      : super(validationMessage);

  @override
  String onValidate(String entityName, T value) {
    String validationMessage = "$entityName is not in list of accepted values";
    return acceptedList.contains(value) ? null : validationMessage;
  }
}
