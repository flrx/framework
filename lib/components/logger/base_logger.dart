import 'package:flrx/application.dart';

abstract class Logger {
  void log(dynamic message);
}

void log(dynamic message) => Application.get<Logger>().log(message);
