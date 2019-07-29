import 'package:flrx/utils/validator/rule.dart';

class EmailRule extends Rule<String> {
  final String emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

  @override
  String validate(String entityName, String value) {
    if (value.isEmpty) {
      return '$entityName should not be empty!';
    }

    RegExp emailRegexp = RegExp(emailRegex);
    if (!emailRegexp.hasMatch(value)) {
      return "$value is not a valid email address";
    }
    return null;
  }
}
