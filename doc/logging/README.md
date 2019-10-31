# Logging

`Flrx` comes with a Console Logger by default.
To use it, Register the Logger first in your `Application.init` or in a `ServiceRegistrar`

```dart
locator.registerSingleton<Logger>(ConsoleLogger());
```

You can also use your own Loggers by extending `Logger`