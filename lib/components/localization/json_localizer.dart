import 'package:flrx/components/localization/base_localizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

class JsonLocalizer extends Localizer {
  JsonLocalizer(
      {@required this.fallbackFile,
      @required this.path,
      @required this.useCountryCode});

  final String fallbackFile;
  final String path;
  final bool useCountryCode;

  @override
  String translate(
    final BuildContext context,
    final String key, {
    final String fallbackKey,
    final Map<String, String> translationParams,
  }) =>
      FlutterI18n.translate(
        context,
        key,
        translationParams: translationParams,
        fallbackKey: fallbackKey,
      );

  @override
  String plural(final BuildContext context, final String key,
          final int pluralValue) =>
      FlutterI18n.plural(context, key, pluralValue);

  @override
  void setLocale(final BuildContext context, final Locale locale) =>
      FlutterI18n.refresh(context, locale);

  @override
  LocalizationsDelegate<Object> getLocalizationDelegate() =>
      FlutterI18nDelegate(
        translationLoader: FileTranslationLoader(
          fallbackFile: fallbackFile,
          basePath: path,
          useCountryCode: useCountryCode,
        ),
      );
}
