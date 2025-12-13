import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'local_storage_providers.g.dart';

/// A provider that returns an instance of [SharedPreferences].
///
/// This provider is overriden in the main file to provide a synchronous
/// instance of [SharedPreferences] (see the ProviderScope). For more
/// information, see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferences(Ref ref) =>
    throw UnimplementedError();
