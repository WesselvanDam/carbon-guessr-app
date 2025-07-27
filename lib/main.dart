import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'i18n/strings.g.dart';
import 'services/local_storage/local_storage_providers.dart';
import 'utils/provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
  runApp(ProviderScope(
    observers: [
      // Add your custom provider observer here
      RiverpodProviderObserver(),
    ],
    overrides: [
      // Override the sharedPreferences provider with the instance
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: TranslationProvider(child: const App()),
  ));
}
