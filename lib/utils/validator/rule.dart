import 'package:flutter/foundation.dart';

@immutable
abstract class Rule<T> {
  String validate(String entityName, T value);
}
