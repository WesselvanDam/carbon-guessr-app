// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'1c7a8df38a2e412ac94b325382659ce12b7d7532';

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
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferencesWithCache>;
String _$localStorageServiceHash() =>
    r'56cf81e398c7e14d35d6cf3729060d80e9ae833e';

/// A provider for the [LocalStorageApi].
///
/// Copied from [localStorageService].
@ProviderFor(localStorageService)
final localStorageServiceProvider =
    AutoDisposeProvider<LocalStorageApi>.internal(
  localStorageService,
  name: r'localStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalStorageServiceRef = AutoDisposeProviderRef<LocalStorageApi>;
String _$localStorageRepositoryHash() =>
    r'c72f633647c1a7e1259941f24f414322a9af3315';

/// A provider for the [LocalStorageRepository].
///
/// Copied from [localStorageRepository].
@ProviderFor(localStorageRepository)
final localStorageRepositoryProvider =
    AutoDisposeProvider<LocalStorageRepository>.internal(
  localStorageRepository,
  name: r'localStorageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalStorageRepositoryRef
    = AutoDisposeProviderRef<LocalStorageRepository>;
String _$localStorageBoolHash() => r'899bca6179a526a34ee1d6838358b65cc449e2e7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A provider that retrieves a boolean value from local storage.
///
/// Copied from [localStorageBool].
@ProviderFor(localStorageBool)
const localStorageBoolProvider = LocalStorageBoolFamily();

/// A provider that retrieves a boolean value from local storage.
///
/// Copied from [localStorageBool].
class LocalStorageBoolFamily extends Family<bool?> {
  /// A provider that retrieves a boolean value from local storage.
  ///
  /// Copied from [localStorageBool].
  const LocalStorageBoolFamily();

  /// A provider that retrieves a boolean value from local storage.
  ///
  /// Copied from [localStorageBool].
  LocalStorageBoolProvider call(
    LocalStorageBoolKeys key,
  ) {
    return LocalStorageBoolProvider(
      key,
    );
  }

  @override
  LocalStorageBoolProvider getProviderOverride(
    covariant LocalStorageBoolProvider provider,
  ) {
    return call(
      provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'localStorageBoolProvider';
}

/// A provider that retrieves a boolean value from local storage.
///
/// Copied from [localStorageBool].
class LocalStorageBoolProvider extends AutoDisposeProvider<bool?> {
  /// A provider that retrieves a boolean value from local storage.
  ///
  /// Copied from [localStorageBool].
  LocalStorageBoolProvider(
    LocalStorageBoolKeys key,
  ) : this._internal(
          (ref) => localStorageBool(
            ref as LocalStorageBoolRef,
            key,
          ),
          from: localStorageBoolProvider,
          name: r'localStorageBoolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$localStorageBoolHash,
          dependencies: LocalStorageBoolFamily._dependencies,
          allTransitiveDependencies:
              LocalStorageBoolFamily._allTransitiveDependencies,
          key: key,
        );

  LocalStorageBoolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final LocalStorageBoolKeys key;

  @override
  Override overrideWith(
    bool? Function(LocalStorageBoolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LocalStorageBoolProvider._internal(
        (ref) => create(ref as LocalStorageBoolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool?> createElement() {
    return _LocalStorageBoolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalStorageBoolProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocalStorageBoolRef on AutoDisposeProviderRef<bool?> {
  /// The parameter `key` of this provider.
  LocalStorageBoolKeys get key;
}

class _LocalStorageBoolProviderElement extends AutoDisposeProviderElement<bool?>
    with LocalStorageBoolRef {
  _LocalStorageBoolProviderElement(super.provider);

  @override
  LocalStorageBoolKeys get key => (origin as LocalStorageBoolProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
