import 'dart:ui';

import 'package:flrx/components/modules/module.dart';
import 'package:flrx/config/application_config.dart';
import 'package:{{name}}/modules/common/module.dart';

/// TODO(ibrahim-mubarak): Need better way of formatting languages
class AppConfig extends ApplicationConfig {
  static const List<String> _supportedLocales = <String>[
    "en",
    "fr",
    "it",
    "de",
  ];

  static List<Locale> get supportedLocales =>
      _supportedLocales.map((String code) => Locale(code)).toList();

  @override
  List<Module> get modules => [CommonModule()];
}
