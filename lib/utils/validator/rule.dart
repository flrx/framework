import 'package:flutter/foundation.dart';

@immutable
abstract class Rule {
  String validate(String entityName, String value);
}
