export 'package:logger/logger.dart';

import 'package:flrx/flrx.dart';

void log(dynamic message) => Application.get<Logger>().d(message);
