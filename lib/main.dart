import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_http_logger/talker_http_logger.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'client/talker.dart';
import 'core/app.dart';
import 'env/env.dart';
import 'i18n/strings.g.dart';
import 'local_storage/local_storage_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    httpClient: InterceptedClient.build(
      interceptors: [TalkerHttpLogger(talker: talker)],
    ),
  );
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
