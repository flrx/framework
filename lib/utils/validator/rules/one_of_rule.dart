import 'package:flrx/utils/validator/rule.dart';

class OneOfRule extends Rule {
  final List<String> acceptedList;

  OneOfRule(this.acceptedList);

  @override
  String validate(String entityName, String value) {
    for (String acceptedValue in acceptedList) {
      if (value == acceptedValue) {
        return null;
      }
    }
    return "$entityName is not in list of accepted values";
  }
}
