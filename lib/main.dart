import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'client/talker.dart';
import 'core/app.dart';
import 'i18n/strings.g.dart';
import 'local_storage/local_storage_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
  runApp(
    ProviderScope(
      observers: [
        TalkerRiverpodObserver(
          talker: talker,
          settings: TalkerRiverpodLoggerSettings(
            printStateFullData: false,
            providerFilter: (provider) => ![
              'timerControllerProvider',
              'ratioControllerProvider',
            ].contains(provider.name),
          ),
        ),
      ],
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: TranslationProvider(child: const App()),
    ),
  );
}
