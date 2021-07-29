import 'package:flrx/application.dart';
import 'package:logger/logger.dart' as logging;

class Logger extends logging.Logger {}

void log(dynamic message) => Application.get<Logger>().log(
      logging.Level.info,
      message,
    );
