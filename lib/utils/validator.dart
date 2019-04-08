class Validator {
  Validator({this.entityName = "Entity"}) {
    _rule = <String, Function>{
      Rules.MIN_LENTH: (String value, Map<String, dynamic> property) {
        dynamic minLength = property["minLength"];
        if (value.length < minLength)
          return "$entityName should be more than $minLength characters";
        return null;
      },
      Rules.EMAIL: _validateEmail
    };
  }
  List<String> list = List<String>();
  String entityName;
  Map<String, Function> _rule = <String, Function>{};

  Validator add(String ruleName, String value,
      [Map<String, dynamic> property]) {
    list.add(_rule[ruleName](value, property));
    return this;
  }

  static String _validateEmail(String value, Map<String, dynamic> property) {
    if (value.isEmpty) {
      return 'Email should not be empty!';
    } else if (!value.contains('@')) {
      return "'@' symbol should be present in the username";
    }
    return null;
  }

  String runRules() {
    for (String rule in list) {
      if (rule != null) {
        return rule;
      }
    }
    return null;
  }
}

class Rules {
  static const String MIN_LENTH = "minLength";
  static const String EMAIL = "email";
}
