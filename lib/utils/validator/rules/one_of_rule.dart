import 'package:flrx/utils/validator/rule.dart';

class OneOfRule<T> extends Rule<T> {
  final List<T> acceptedList;

  OneOfRule(this.acceptedList);

  @override
  String validate(String entityName, T value) {
    for (T acceptedValue in acceptedList) {
      if (value == acceptedValue) {
        return null;
      }
    }
    return "$entityName is not in list of accepted values";
  }
}
