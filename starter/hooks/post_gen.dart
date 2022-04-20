import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  var packagesToInstall = ['melos', 'spider', 'define_env'];

  packagesToInstall.forEach((package) {
    context.logger.info('Installing $package');
    Process.runSync(
      "flutter",
      [
        'pub',
        'global',
        'activate',
        package,
      ],
      runInShell: true,
    );
  });

  context.logger.info('');
  context.logger.info('Project created');
  context.logger
      .info('Run `flutter create` and `melos bootstrap` to setup your project');
  context.logger.info('Time to make something great!');
}
