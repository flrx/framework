import 'package:easy_localization/easy_localization.dart';
import 'package:flrx/components/error_manager/error_manager.dart';
import 'package:flrx/flrx.dart';
import 'package:{{name}}/app.dart';
import 'package:{{name}}/config/app_config.dart';
import 'package:{{name}}/store/store_retriever.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var app = Application(
    () async => runApp(await initAppWidget()),
    appConfig: AppConfig(),
  );

  Application.serviceLocator.registerSingleton<ErrorManager>(
    CatcherErrorManager(
      catcherConfig: CatcherConfig(),
      navigatorKey: Application.config.navigatorKey,
    ),
  );

  app.init();
}

Future<Widget> initAppWidget() async {
  await EasyLocalization.ensureInitialized();

  return EasyLocalization(
    supportedLocales: AppConfig.supportedLocales,
    path: 'assets/translations',
    child: App(store: await AppStoreRetriever().retrieveStore()),
  );
}
