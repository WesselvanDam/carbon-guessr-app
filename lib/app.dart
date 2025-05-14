import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/theme.dart';
import 'i18n/strings.g.dart';
import 'services/navigation/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    final textTheme = createTextTheme(context);
    final theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: theme.dark(),
      routerConfig: router,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [...GlobalMaterialLocalizations.delegates],
    );
  }
}
