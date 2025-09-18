import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_api.dart';
import 'local_storage_keys.dart';
import 'local_storage_repository.dart';

part 'local_storage_providers.g.dart';

/// A provider that returns an instance of [SharedPreferences].
///
/// This provider is overriden in the main file to provide a synchronous
/// instance of [SharedPreferences] (see the ProviderScope). For more
/// information, see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
///
/// Currently, the provider merely returns the instance of [SharedPreferences],
/// and this is used throughout the app to store and retrieve data from the
/// device's local storage. Alternatively, a service could be made out of this
/// provider to handle the storage and retrieval of data in a more structured
/// way. This would allow for better separation of concerns and more testable
/// code, as well as avoiding writing all the key strings throughout the app.
///
/// {@category Services}
@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferences(Ref ref) =>
    throw UnimplementedError();

/// A provider for the [LocalStorageApi].
@riverpod
LocalStorageApi localStorageService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageApi(prefs);
}

/// A provider for the [LocalStorageRepository].
@riverpod
LocalStorageRepository localStorageRepository(Ref ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return LocalStorageRepository(localStorageService);
}

/// A provider that retrieves a boolean value from local storage.
@riverpod
bool? localStorageBool(Ref ref, LocalStorageBoolKeys key) {
  final repository = ref.watch(localStorageRepositoryProvider);
  return repository.getBool(key);
}
