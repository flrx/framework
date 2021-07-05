# Error Handling

`Flrx` comes with Sentry Error Reporting by default.
To use it, Register the Error Reporter first in your `Application.init` or in a `ServiceRegistrar`

```dart
locator.registerSingleton<ErrorReporter>(SentryErrorReporter(dsn: "dsn"));
```

You can also use your own Error Reporters by extending `ErrorReporter`