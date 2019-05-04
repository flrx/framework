import 'package:args/args.dart';
import 'package:path/path.dart' as path_library;

abstract class Command {
  final ArgParser argParser;
  Command(this.argParser);
  String get name;
  String get help;
  String get abbr;
  int handler(ArgResults results);
  String separator = path_library.separator;
}
