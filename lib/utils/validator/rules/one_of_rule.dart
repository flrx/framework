import 'package:flrx/utils/validator/rule.dart';

class OneOfRule<T> extends Rule<T> {
  final List<T> acceptedList;

  OneOfRule(this.acceptedList);

  @override
  String validate(String entityName, T value) {
    String validationMessage = "$entityName is not in list of accepted values";
    return acceptedList.contains(value) ? null : validationMessage;
  }
}
