import 'package:flrx/application.dart';
import 'package:flutter/widgets.dart';

abstract class Localizer {
  String translate(
    final BuildContext context,
    final String key, {
    final Map<String, String>? translationParams,
  });

  String plural(
      final BuildContext context, final String key, final int pluralValue);

  void setLocale(final BuildContext context, final Locale locale);

  LocalizationsDelegate<Object> getLocalizationDelegate();
}

// ignore: unused_element, non_constant_identifier_names
String translate(
  final BuildContext context,
  final String key, {
  final Map<String, String>? translationParams,
}) =>
    Application.get<Localizer>()
        .translate(context, key, translationParams: translationParams);
