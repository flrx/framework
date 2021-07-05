# Localization

`Flrx` comes with a Json Localizer by default.
To use it, Register the Error Reporter first in your `Application.init` or in a `ServiceRegistrar`

```dart
locator.registerLazySingleton<Localizer>(() => JsonLocalizer(
  fallbackFile: 'en',
  path: "assets/i18n",
  useCountryCode: false,
  ));
```

You can also use your own Localizers by extending `Localizer`