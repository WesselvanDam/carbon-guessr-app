import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_keys.dart';
import 'local_storage_repository.dart';

part 'local_storage_providers.g.dart';

/// A provider that returns an instance of [SharedPreferences].
///
/// This provider is overriden in the main file to provide a synchronous
/// instance of [SharedPreferences] (see the ProviderScope). For more
/// information, see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferences(Ref ref) =>
    throw UnimplementedError();


/// A provider that retrieves a boolean value from local storage.
@riverpod
bool? localStorageBool(Ref ref, LocalStorageBoolKeys key) {
  final repository = ref.watch(localStorageRepositoryProvider);
  return repository.getBool(key);
}
