// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentCollectionHash() => r'6f203a6ebba9b6897c100f7f1155799f6015806f';

/// Provider for the currently selected collection name
///
/// Copied from [currentCollection].
@ProviderFor(currentCollection)
final currentCollectionProvider = AutoDisposeProvider<String>.internal(
  currentCollection,
  name: r'currentCollectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCollectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentCollectionRef = AutoDisposeProviderRef<String>;
String _$collectionServiceHash() => r'b2867c84d082c9c482120b8dd6132eef8785c642';

/// Provider for the CollectionService
///
/// Copied from [collectionService].
@ProviderFor(collectionService)
final collectionServiceProvider =
    AutoDisposeProvider<CollectionService>.internal(
  collectionService,
  name: r'collectionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CollectionServiceRef = AutoDisposeProviderRef<CollectionService>;
String _$collectionRepositoryHash() =>
    r'2710c89868ffbed166861aee6ee4994de88adb36';

/// Provider for the CollectionRepository
///
/// Copied from [collectionRepository].
@ProviderFor(collectionRepository)
final collectionRepositoryProvider =
    AutoDisposeProvider<CollectionRepository>.internal(
  collectionRepository,
  name: r'collectionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CollectionRepositoryRef = AutoDisposeProviderRef<CollectionRepository>;
String _$collectionInfoHash() => r'420796640994fbd00f45916da00a26e9316fb1ca';

/// Provider for the collection info
///
/// Copied from [collectionInfo].
@ProviderFor(collectionInfo)
final collectionInfoProvider =
    AutoDisposeFutureProvider<CollectionInfo>.internal(
  collectionInfo,
  name: r'collectionInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectionInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CollectionInfoRef = AutoDisposeFutureProviderRef<CollectionInfo>;
String _$collectionItemHash() => r'3217893417c181e3403519028050ff59c2ade64d';

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

/// Provider for a specific collection item by ID
///
/// Copied from [collectionItem].
@ProviderFor(collectionItem)
const collectionItemProvider = CollectionItemFamily();

/// Provider for a specific collection item by ID
///
/// Copied from [collectionItem].
class CollectionItemFamily extends Family<AsyncValue<CollectionItem>> {
  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  const CollectionItemFamily();

  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  CollectionItemProvider call(
    int id,
  ) {
    return CollectionItemProvider(
      id,
    );
  }

  @override
  CollectionItemProvider getProviderOverride(
    covariant CollectionItemProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'collectionItemProvider';
}

/// Provider for a specific collection item by ID
///
/// Copied from [collectionItem].
class CollectionItemProvider extends AutoDisposeFutureProvider<CollectionItem> {
  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  CollectionItemProvider(
    int id,
  ) : this._internal(
          (ref) => collectionItem(
            ref as CollectionItemRef,
            id,
          ),
          from: collectionItemProvider,
          name: r'collectionItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionItemHash,
          dependencies: CollectionItemFamily._dependencies,
          allTransitiveDependencies:
              CollectionItemFamily._allTransitiveDependencies,
          id: id,
        );

  CollectionItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<CollectionItem> Function(CollectionItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionItemProvider._internal(
        (ref) => create(ref as CollectionItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CollectionItem> createElement() {
    return _CollectionItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionItemProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemRef on AutoDisposeFutureProviderRef<CollectionItem> {
  /// The parameter `id` of this provider.
  int get id;
}

class _CollectionItemProviderElement
    extends AutoDisposeFutureProviderElement<CollectionItem>
    with CollectionItemRef {
  _CollectionItemProviderElement(super.provider);

  @override
  int get id => (origin as CollectionItemProvider).id;
}

String _$allCollectionItemsHash() =>
    r'91295665b4cea3bc26554ae8d5fe364ff31ae4a0';

/// Provider for all collection items
///
/// Copied from [allCollectionItems].
@ProviderFor(allCollectionItems)
final allCollectionItemsProvider =
    AutoDisposeFutureProvider<List<CollectionItem>>.internal(
  allCollectionItems,
  name: r'allCollectionItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCollectionItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCollectionItemsRef
    = AutoDisposeFutureProviderRef<List<CollectionItem>>;
String _$collectionItemsByIdsHash() =>
    r'352dbec8bd53179c0111fadec9c269ef13b89599';

/// Provider for specific collection items by IDs
///
/// Copied from [collectionItemsByIds].
@ProviderFor(collectionItemsByIds)
const collectionItemsByIdsProvider = CollectionItemsByIdsFamily();

/// Provider for specific collection items by IDs
///
/// Copied from [collectionItemsByIds].
class CollectionItemsByIdsFamily
    extends Family<AsyncValue<List<CollectionItem>>> {
  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  const CollectionItemsByIdsFamily();

  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  CollectionItemsByIdsProvider call(
    List<int> ids,
  ) {
    return CollectionItemsByIdsProvider(
      ids,
    );
  }

  @override
  CollectionItemsByIdsProvider getProviderOverride(
    covariant CollectionItemsByIdsProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'collectionItemsByIdsProvider';
}

/// Provider for specific collection items by IDs
///
/// Copied from [collectionItemsByIds].
class CollectionItemsByIdsProvider
    extends AutoDisposeFutureProvider<List<CollectionItem>> {
  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  CollectionItemsByIdsProvider(
    List<int> ids,
  ) : this._internal(
          (ref) => collectionItemsByIds(
            ref as CollectionItemsByIdsRef,
            ids,
          ),
          from: collectionItemsByIdsProvider,
          name: r'collectionItemsByIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionItemsByIdsHash,
          dependencies: CollectionItemsByIdsFamily._dependencies,
          allTransitiveDependencies:
              CollectionItemsByIdsFamily._allTransitiveDependencies,
          ids: ids,
        );

  CollectionItemsByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final List<int> ids;

  @override
  Override overrideWith(
    FutureOr<List<CollectionItem>> Function(CollectionItemsByIdsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionItemsByIdsProvider._internal(
        (ref) => create(ref as CollectionItemsByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CollectionItem>> createElement() {
    return _CollectionItemsByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionItemsByIdsProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemsByIdsRef
    on AutoDisposeFutureProviderRef<List<CollectionItem>> {
  /// The parameter `ids` of this provider.
  List<int> get ids;
}

class _CollectionItemsByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<CollectionItem>>
    with CollectionItemsByIdsRef {
  _CollectionItemsByIdsProviderElement(super.provider);

  @override
  List<int> get ids => (origin as CollectionItemsByIdsProvider).ids;
}

String _$collectionItemSourcesHash() =>
    r'ac058938581eafd5bc203887bd3dd3f15778114a';

/// Provider for sources of a specific collection item
///
/// Copied from [collectionItemSources].
@ProviderFor(collectionItemSources)
const collectionItemSourcesProvider = CollectionItemSourcesFamily();

/// Provider for sources of a specific collection item
///
/// Copied from [collectionItemSources].
class CollectionItemSourcesFamily extends Family<AsyncValue<List<Source>>> {
  /// Provider for sources of a specific collection item
  ///
  /// Copied from [collectionItemSources].
  const CollectionItemSourcesFamily();

  /// Provider for sources of a specific collection item
  ///
  /// Copied from [collectionItemSources].
  CollectionItemSourcesProvider call(
    int itemId,
  ) {
    return CollectionItemSourcesProvider(
      itemId,
    );
  }

  @override
  CollectionItemSourcesProvider getProviderOverride(
    covariant CollectionItemSourcesProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'collectionItemSourcesProvider';
}

/// Provider for sources of a specific collection item
///
/// Copied from [collectionItemSources].
class CollectionItemSourcesProvider
    extends AutoDisposeFutureProvider<List<Source>> {
  /// Provider for sources of a specific collection item
  ///
  /// Copied from [collectionItemSources].
  CollectionItemSourcesProvider(
    int itemId,
  ) : this._internal(
          (ref) => collectionItemSources(
            ref as CollectionItemSourcesRef,
            itemId,
          ),
          from: collectionItemSourcesProvider,
          name: r'collectionItemSourcesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionItemSourcesHash,
          dependencies: CollectionItemSourcesFamily._dependencies,
          allTransitiveDependencies:
              CollectionItemSourcesFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  CollectionItemSourcesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final int itemId;

  @override
  Override overrideWith(
    FutureOr<List<Source>> Function(CollectionItemSourcesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionItemSourcesProvider._internal(
        (ref) => create(ref as CollectionItemSourcesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Source>> createElement() {
    return _CollectionItemSourcesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionItemSourcesProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemSourcesRef on AutoDisposeFutureProviderRef<List<Source>> {
  /// The parameter `itemId` of this provider.
  int get itemId;
}

class _CollectionItemSourcesProviderElement
    extends AutoDisposeFutureProviderElement<List<Source>>
    with CollectionItemSourcesRef {
  _CollectionItemSourcesProviderElement(super.provider);

  @override
  int get itemId => (origin as CollectionItemSourcesProvider).itemId;
}

String _$localizedCollectionItemHash() =>
    r'4e824f2c2d9c99ad91ea6663c29416ae098ebad9';

/// Provider for a localized collection item
///
/// Copied from [localizedCollectionItem].
@ProviderFor(localizedCollectionItem)
const localizedCollectionItemProvider = LocalizedCollectionItemFamily();

/// Provider for a localized collection item
///
/// Copied from [localizedCollectionItem].
class LocalizedCollectionItemFamily extends Family<AsyncValue<CollectionItem>> {
  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  const LocalizedCollectionItemFamily();

  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  LocalizedCollectionItemProvider call(
    int id,
    String locale,
  ) {
    return LocalizedCollectionItemProvider(
      id,
      locale,
    );
  }

  @override
  LocalizedCollectionItemProvider getProviderOverride(
    covariant LocalizedCollectionItemProvider provider,
  ) {
    return call(
      provider.id,
      provider.locale,
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
  String? get name => r'localizedCollectionItemProvider';
}

/// Provider for a localized collection item
///
/// Copied from [localizedCollectionItem].
class LocalizedCollectionItemProvider
    extends AutoDisposeFutureProvider<CollectionItem> {
  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  LocalizedCollectionItemProvider(
    int id,
    String locale,
  ) : this._internal(
          (ref) => localizedCollectionItem(
            ref as LocalizedCollectionItemRef,
            id,
            locale,
          ),
          from: localizedCollectionItemProvider,
          name: r'localizedCollectionItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$localizedCollectionItemHash,
          dependencies: LocalizedCollectionItemFamily._dependencies,
          allTransitiveDependencies:
              LocalizedCollectionItemFamily._allTransitiveDependencies,
          id: id,
          locale: locale,
        );

  LocalizedCollectionItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.locale,
  }) : super.internal();

  final int id;
  final String locale;

  @override
  Override overrideWith(
    FutureOr<CollectionItem> Function(LocalizedCollectionItemRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LocalizedCollectionItemProvider._internal(
        (ref) => create(ref as LocalizedCollectionItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        locale: locale,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CollectionItem> createElement() {
    return _LocalizedCollectionItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalizedCollectionItemProvider &&
        other.id == id &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, locale.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocalizedCollectionItemRef
    on AutoDisposeFutureProviderRef<CollectionItem> {
  /// The parameter `id` of this provider.
  int get id;

  /// The parameter `locale` of this provider.
  String get locale;
}

class _LocalizedCollectionItemProviderElement
    extends AutoDisposeFutureProviderElement<CollectionItem>
    with LocalizedCollectionItemRef {
  _LocalizedCollectionItemProviderElement(super.provider);

  @override
  int get id => (origin as LocalizedCollectionItemProvider).id;
  @override
  String get locale => (origin as LocalizedCollectionItemProvider).locale;
}

String _$allLocalizedCollectionItemsHash() =>
    r'668d18bdcd165d7e88a8c322317b710941968cce';

/// Provider for all localized collection items
///
/// Copied from [allLocalizedCollectionItems].
@ProviderFor(allLocalizedCollectionItems)
const allLocalizedCollectionItemsProvider = AllLocalizedCollectionItemsFamily();

/// Provider for all localized collection items
///
/// Copied from [allLocalizedCollectionItems].
class AllLocalizedCollectionItemsFamily
    extends Family<AsyncValue<List<CollectionItem>>> {
  /// Provider for all localized collection items
  ///
  /// Copied from [allLocalizedCollectionItems].
  const AllLocalizedCollectionItemsFamily();

  /// Provider for all localized collection items
  ///
  /// Copied from [allLocalizedCollectionItems].
  AllLocalizedCollectionItemsProvider call(
    String locale,
  ) {
    return AllLocalizedCollectionItemsProvider(
      locale,
    );
  }

  @override
  AllLocalizedCollectionItemsProvider getProviderOverride(
    covariant AllLocalizedCollectionItemsProvider provider,
  ) {
    return call(
      provider.locale,
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
  String? get name => r'allLocalizedCollectionItemsProvider';
}

/// Provider for all localized collection items
///
/// Copied from [allLocalizedCollectionItems].
class AllLocalizedCollectionItemsProvider
    extends AutoDisposeFutureProvider<List<CollectionItem>> {
  /// Provider for all localized collection items
  ///
  /// Copied from [allLocalizedCollectionItems].
  AllLocalizedCollectionItemsProvider(
    String locale,
  ) : this._internal(
          (ref) => allLocalizedCollectionItems(
            ref as AllLocalizedCollectionItemsRef,
            locale,
          ),
          from: allLocalizedCollectionItemsProvider,
          name: r'allLocalizedCollectionItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allLocalizedCollectionItemsHash,
          dependencies: AllLocalizedCollectionItemsFamily._dependencies,
          allTransitiveDependencies:
              AllLocalizedCollectionItemsFamily._allTransitiveDependencies,
          locale: locale,
        );

  AllLocalizedCollectionItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.locale,
  }) : super.internal();

  final String locale;

  @override
  Override overrideWith(
    FutureOr<List<CollectionItem>> Function(
            AllLocalizedCollectionItemsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllLocalizedCollectionItemsProvider._internal(
        (ref) => create(ref as AllLocalizedCollectionItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        locale: locale,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CollectionItem>> createElement() {
    return _AllLocalizedCollectionItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllLocalizedCollectionItemsProvider &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, locale.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllLocalizedCollectionItemsRef
    on AutoDisposeFutureProviderRef<List<CollectionItem>> {
  /// The parameter `locale` of this provider.
  String get locale;
}

class _AllLocalizedCollectionItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<CollectionItem>>
    with AllLocalizedCollectionItemsRef {
  _AllLocalizedCollectionItemsProviderElement(super.provider);

  @override
  String get locale => (origin as AllLocalizedCollectionItemsProvider).locale;
}

String _$currentCollectionNotifierHash() =>
    r'780e2bf6cfa707c0c80428432a55eb8c96054b4a';

/// A notifier provider that allows changing the current collection
///
/// Copied from [CurrentCollectionNotifier].
@ProviderFor(CurrentCollectionNotifier)
final currentCollectionNotifierProvider =
    AutoDisposeNotifierProvider<CurrentCollectionNotifier, String>.internal(
  CurrentCollectionNotifier.new,
  name: r'currentCollectionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCollectionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentCollectionNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
