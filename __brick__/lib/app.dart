import 'package:easy_localization/easy_localization.dart';
import 'package:flrx/flrx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:{{name}}/config/theme_config.dart';
import 'package:{{name}}/store/states/app_state.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        theme: ThemeConfig.getTheme(),
        onGenerateRoute: AppRouter.router.generator,
      ),
    );
  }
}
