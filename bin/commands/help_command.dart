import 'package:args/args.dart';

import 'base_command.dart';

class HelpCommand extends Command {
  HelpCommand(ArgParser argParser) : super(argParser);

  @override
  String get abbr => 'h';

  @override
  int handler(options) {
    print(argParser.usage);
    return 0;
  }

  @override
  String get help => 'Prints Usage';

  @override
  String get name => 'help';
}
