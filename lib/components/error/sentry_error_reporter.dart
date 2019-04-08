import 'package:flrx/components/error/error_reporter.dart';
import 'package:flrx/components/logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:sentry/sentry.dart';

/// Sentry Error Reporter from [https://flutter.dev/docs/cookbook/maintenance/error-reporting]
class SentryErrorReporter extends ErrorReporter {
  SentryErrorReporter({@required String dsn})
      : _sentry = SentryClient(dsn: dsn);

  final SentryClient _sentry;

  /// Reports [error] along with its [stackTrace] to Sentry.io.
  @override
  void reportError(dynamic error, StackTrace stackTrace) async {
    log('Reporting to Sentry.io...');
    final SentryResponse response = await _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );

    if (response.isSuccessful) {
      log('Success! Event ID: ${response.eventId}');
    } else {
      log('Failed to report to Sentry.io: ${response.error}');
    }
  }
}
