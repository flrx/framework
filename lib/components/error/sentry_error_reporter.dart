import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:sentry/sentry.dart';

/// Sentry Error Reporter from [https://flutter.dev/docs/cookbook/maintenance/error-reporting]
class SentryErrorReporter with ErrorReporter {
  SentryErrorReporter({required String dsn}) {
    Sentry.init((options) => options.dsn = dsn);
  }

  /// Reports [error] along with its [stackTrace] to Sentry.io.
  @override
  void reportError(dynamic error, StackTrace stackTrace) async {
    log('Reporting to Sentry.io...');
    try {
      final response = await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
      log('Success! Event ID: $response');
    } catch (e) {
      log('Failed to report to Sentry.io: $e');
    }
  }
}
