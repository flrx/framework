import 'package:flrx/components/logger/logger.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Logger>(returnNullOnMissingStub: true),
])

/// The generator can run only if annotated with top level function or variable
/// This dummy function is used to create mocks
void dummy() {}
