// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectionServiceHash() => r'fc48e0e43c63d1bdcc7a4260f59d71e638872ba3';

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

/// Provider for the CollectionService
///
/// Copied from [collectionService].
@ProviderFor(collectionService)
const collectionServiceProvider = CollectionServiceFamily();

/// Provider for the CollectionService
///
/// Copied from [collectionService].
class CollectionServiceFamily extends Family<CollectionApi> {
  /// Provider for the CollectionService
  ///
  /// Copied from [collectionService].
  const CollectionServiceFamily();

  /// Provider for the CollectionService
  ///
  /// Copied from [collectionService].
  CollectionServiceProvider call(
    String collectionId,
  ) {
    return CollectionServiceProvider(
      collectionId,
    );
  }

  @override
  CollectionServiceProvider getProviderOverride(
    covariant CollectionServiceProvider provider,
  ) {
    return call(
      provider.collectionId,
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
  String? get name => r'collectionServiceProvider';
}

/// Provider for the CollectionService
///
/// Copied from [collectionService].
class CollectionServiceProvider extends AutoDisposeProvider<CollectionApi> {
  /// Provider for the CollectionService
  ///
  /// Copied from [collectionService].
  CollectionServiceProvider(
    String collectionId,
  ) : this._internal(
          (ref) => collectionService(
            ref as CollectionServiceRef,
            collectionId,
          ),
          from: collectionServiceProvider,
          name: r'collectionServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionServiceHash,
          dependencies: CollectionServiceFamily._dependencies,
          allTransitiveDependencies:
              CollectionServiceFamily._allTransitiveDependencies,
          collectionId: collectionId,
        );

  CollectionServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
  }) : super.internal();

  final String collectionId;

  @override
  Override overrideWith(
    CollectionApi Function(CollectionServiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionServiceProvider._internal(
        (ref) => create(ref as CollectionServiceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionId: collectionId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionApi> createElement() {
    return _CollectionServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionServiceProvider &&
        other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionServiceRef on AutoDisposeProviderRef<CollectionApi> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;
}

class _CollectionServiceProviderElement
    extends AutoDisposeProviderElement<CollectionApi>
    with CollectionServiceRef {
  _CollectionServiceProviderElement(super.provider);

  @override
  String get collectionId => (origin as CollectionServiceProvider).collectionId;
}

String _$collectionRepositoryHash() =>
    r'ccae2de6d2abe5cc2338bec499f68c24765c4598';

/// Provider for the CollectionRepository
///
/// Copied from [collectionRepository].
@ProviderFor(collectionRepository)
const collectionRepositoryProvider = CollectionRepositoryFamily();

/// Provider for the CollectionRepository
///
/// Copied from [collectionRepository].
class CollectionRepositoryFamily extends Family<CollectionRepository> {
  /// Provider for the CollectionRepository
  ///
  /// Copied from [collectionRepository].
  const CollectionRepositoryFamily();

  /// Provider for the CollectionRepository
  ///
  /// Copied from [collectionRepository].
  CollectionRepositoryProvider call(
    String collectionId,
  ) {
    return CollectionRepositoryProvider(
      collectionId,
    );
  }

  @override
  CollectionRepositoryProvider getProviderOverride(
    covariant CollectionRepositoryProvider provider,
  ) {
    return call(
      provider.collectionId,
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
  String? get name => r'collectionRepositoryProvider';
}

/// Provider for the CollectionRepository
///
/// Copied from [collectionRepository].
class CollectionRepositoryProvider
    extends AutoDisposeProvider<CollectionRepository> {
  /// Provider for the CollectionRepository
  ///
  /// Copied from [collectionRepository].
  CollectionRepositoryProvider(
    String collectionId,
  ) : this._internal(
          (ref) => collectionRepository(
            ref as CollectionRepositoryRef,
            collectionId,
          ),
          from: collectionRepositoryProvider,
          name: r'collectionRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionRepositoryHash,
          dependencies: CollectionRepositoryFamily._dependencies,
          allTransitiveDependencies:
              CollectionRepositoryFamily._allTransitiveDependencies,
          collectionId: collectionId,
        );

  CollectionRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
  }) : super.internal();

  final String collectionId;

  @override
  Override overrideWith(
    CollectionRepository Function(CollectionRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionRepositoryProvider._internal(
        (ref) => create(ref as CollectionRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionId: collectionId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionRepository> createElement() {
    return _CollectionRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionRepositoryProvider &&
        other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionRepositoryRef on AutoDisposeProviderRef<CollectionRepository> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;
}

class _CollectionRepositoryProviderElement
    extends AutoDisposeProviderElement<CollectionRepository>
    with CollectionRepositoryRef {
  _CollectionRepositoryProviderElement(super.provider);

  @override
  String get collectionId =>
      (origin as CollectionRepositoryProvider).collectionId;
}

String _$collectionsHash() => r'1888ea2dedda0a1e3f0d61623fba5ddcbbc5b3f8';

/// See also [collections].
@ProviderFor(collections)
final collectionsProvider =
    FutureProvider<Map<String, CollectionModel>>.internal(
  collections,
  name: r'collectionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$collectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CollectionsRef = FutureProviderRef<Map<String, CollectionModel>>;
String _$collectionHash() => r'7a4448327ea98f9aabe568abe746057820844ff6';

/// Provider for the collection info
///
/// Copied from [collection].
@ProviderFor(collection)
const collectionProvider = CollectionFamily();

/// Provider for the collection info
///
/// Copied from [collection].
class CollectionFamily extends Family<AsyncValue<CollectionModel>> {
  /// Provider for the collection info
  ///
  /// Copied from [collection].
  const CollectionFamily();

  /// Provider for the collection info
  ///
  /// Copied from [collection].
  CollectionProvider call(
    String collectionId,
  ) {
    return CollectionProvider(
      collectionId,
    );
  }

  @override
  CollectionProvider getProviderOverride(
    covariant CollectionProvider provider,
  ) {
    return call(
      provider.collectionId,
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
  String? get name => r'collectionProvider';
}

/// Provider for the collection info
///
/// Copied from [collection].
class CollectionProvider extends AutoDisposeFutureProvider<CollectionModel> {
  /// Provider for the collection info
  ///
  /// Copied from [collection].
  CollectionProvider(
    String collectionId,
  ) : this._internal(
          (ref) => collection(
            ref as CollectionRef,
            collectionId,
          ),
          from: collectionProvider,
          name: r'collectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionHash,
          dependencies: CollectionFamily._dependencies,
          allTransitiveDependencies:
              CollectionFamily._allTransitiveDependencies,
          collectionId: collectionId,
        );

  CollectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
  }) : super.internal();

  final String collectionId;

  @override
  Override overrideWith(
    FutureOr<CollectionModel> Function(CollectionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionProvider._internal(
        (ref) => create(ref as CollectionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionId: collectionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CollectionModel> createElement() {
    return _CollectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionProvider && other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionRef on AutoDisposeFutureProviderRef<CollectionModel> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;
}

class _CollectionProviderElement
    extends AutoDisposeFutureProviderElement<CollectionModel>
    with CollectionRef {
  _CollectionProviderElement(super.provider);

  @override
  String get collectionId => (origin as CollectionProvider).collectionId;
}

String _$currentCollectionHash() => r'2d46fed2a957ddd25a3f7a3f066522ede3b6c239';

/// See also [currentCollection].
@ProviderFor(currentCollection)
final currentCollectionProvider =
    AutoDisposeFutureProvider<CollectionModel?>.internal(
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
typedef CurrentCollectionRef = AutoDisposeFutureProviderRef<CollectionModel?>;
String _$collectionItemHash() => r'fa35c2e4552412d826d5aee8a2de67e711bf6af4';

/// Provider for a specific collection item by ID
///
/// Copied from [collectionItem].
@ProviderFor(collectionItem)
const collectionItemProvider = CollectionItemFamily();

/// Provider for a specific collection item by ID
///
/// Copied from [collectionItem].
class CollectionItemFamily extends Family<AsyncValue<ItemModel>> {
  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  const CollectionItemFamily();

  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  CollectionItemProvider call(
    String collectionId,
    int id,
  ) {
    return CollectionItemProvider(
      collectionId,
      id,
    );
  }

  @override
  CollectionItemProvider getProviderOverride(
    covariant CollectionItemProvider provider,
  ) {
    return call(
      provider.collectionId,
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
class CollectionItemProvider extends AutoDisposeFutureProvider<ItemModel> {
  /// Provider for a specific collection item by ID
  ///
  /// Copied from [collectionItem].
  CollectionItemProvider(
    String collectionId,
    int id,
  ) : this._internal(
          (ref) => collectionItem(
            ref as CollectionItemRef,
            collectionId,
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
          collectionId: collectionId,
          id: id,
        );

  CollectionItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
    required this.id,
  }) : super.internal();

  final String collectionId;
  final int id;

  @override
  Override overrideWith(
    FutureOr<ItemModel> Function(CollectionItemRef provider) create,
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
        collectionId: collectionId,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ItemModel> createElement() {
    return _CollectionItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionItemProvider &&
        other.collectionId == collectionId &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemRef on AutoDisposeFutureProviderRef<ItemModel> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `id` of this provider.
  int get id;
}

class _CollectionItemProviderElement
    extends AutoDisposeFutureProviderElement<ItemModel> with CollectionItemRef {
  _CollectionItemProviderElement(super.provider);

  @override
  String get collectionId => (origin as CollectionItemProvider).collectionId;
  @override
  int get id => (origin as CollectionItemProvider).id;
}

String _$collectionItemsByIdsHash() =>
    r'64aacf44224639f964c546ff111de7fa41c3ab25';

/// Provider for specific collection items by IDs
///
/// Copied from [collectionItemsByIds].
@ProviderFor(collectionItemsByIds)
const collectionItemsByIdsProvider = CollectionItemsByIdsFamily();

/// Provider for specific collection items by IDs
///
/// Copied from [collectionItemsByIds].
class CollectionItemsByIdsFamily extends Family<AsyncValue<List<ItemModel>>> {
  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  const CollectionItemsByIdsFamily();

  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  CollectionItemsByIdsProvider call(
    String collectionId,
    List<int> ids,
  ) {
    return CollectionItemsByIdsProvider(
      collectionId,
      ids,
    );
  }

  @override
  CollectionItemsByIdsProvider getProviderOverride(
    covariant CollectionItemsByIdsProvider provider,
  ) {
    return call(
      provider.collectionId,
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
    extends AutoDisposeFutureProvider<List<ItemModel>> {
  /// Provider for specific collection items by IDs
  ///
  /// Copied from [collectionItemsByIds].
  CollectionItemsByIdsProvider(
    String collectionId,
    List<int> ids,
  ) : this._internal(
          (ref) => collectionItemsByIds(
            ref as CollectionItemsByIdsRef,
            collectionId,
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
          collectionId: collectionId,
          ids: ids,
        );

  CollectionItemsByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
    required this.ids,
  }) : super.internal();

  final String collectionId;
  final List<int> ids;

  @override
  Override overrideWith(
    FutureOr<List<ItemModel>> Function(CollectionItemsByIdsRef provider) create,
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
        collectionId: collectionId,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ItemModel>> createElement() {
    return _CollectionItemsByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionItemsByIdsProvider &&
        other.collectionId == collectionId &&
        other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemsByIdsRef on AutoDisposeFutureProviderRef<List<ItemModel>> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `ids` of this provider.
  List<int> get ids;
}

class _CollectionItemsByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<ItemModel>>
    with CollectionItemsByIdsRef {
  _CollectionItemsByIdsProviderElement(super.provider);

  @override
  String get collectionId =>
      (origin as CollectionItemsByIdsProvider).collectionId;
  @override
  List<int> get ids => (origin as CollectionItemsByIdsProvider).ids;
}

String _$collectionItemSourcesHash() =>
    r'd43da6161c6e4f553fb58c8a807e5a4060a2c391';

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
    String collectionId,
    int itemId,
  ) {
    return CollectionItemSourcesProvider(
      collectionId,
      itemId,
    );
  }

  @override
  CollectionItemSourcesProvider getProviderOverride(
    covariant CollectionItemSourcesProvider provider,
  ) {
    return call(
      provider.collectionId,
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
    String collectionId,
    int itemId,
  ) : this._internal(
          (ref) => collectionItemSources(
            ref as CollectionItemSourcesRef,
            collectionId,
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
          collectionId: collectionId,
          itemId: itemId,
        );

  CollectionItemSourcesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
    required this.itemId,
  }) : super.internal();

  final String collectionId;
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
        collectionId: collectionId,
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
    return other is CollectionItemSourcesProvider &&
        other.collectionId == collectionId &&
        other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionItemSourcesRef on AutoDisposeFutureProviderRef<List<Source>> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `itemId` of this provider.
  int get itemId;
}

class _CollectionItemSourcesProviderElement
    extends AutoDisposeFutureProviderElement<List<Source>>
    with CollectionItemSourcesRef {
  _CollectionItemSourcesProviderElement(super.provider);

  @override
  String get collectionId =>
      (origin as CollectionItemSourcesProvider).collectionId;
  @override
  int get itemId => (origin as CollectionItemSourcesProvider).itemId;
}

String _$localizedCollectionItemHash() =>
    r'8f59fa18aeed5e0e00738e7fd13028fca6ca3fda';

/// Provider for a localized collection item
///
/// Copied from [localizedCollectionItem].
@ProviderFor(localizedCollectionItem)
const localizedCollectionItemProvider = LocalizedCollectionItemFamily();

/// Provider for a localized collection item
///
/// Copied from [localizedCollectionItem].
class LocalizedCollectionItemFamily extends Family<AsyncValue<ItemModel>> {
  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  const LocalizedCollectionItemFamily();

  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  LocalizedCollectionItemProvider call(
    String collectionId,
    int id,
    String locale,
  ) {
    return LocalizedCollectionItemProvider(
      collectionId,
      id,
      locale,
    );
  }

  @override
  LocalizedCollectionItemProvider getProviderOverride(
    covariant LocalizedCollectionItemProvider provider,
  ) {
    return call(
      provider.collectionId,
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
    extends AutoDisposeFutureProvider<ItemModel> {
  /// Provider for a localized collection item
  ///
  /// Copied from [localizedCollectionItem].
  LocalizedCollectionItemProvider(
    String collectionId,
    int id,
    String locale,
  ) : this._internal(
          (ref) => localizedCollectionItem(
            ref as LocalizedCollectionItemRef,
            collectionId,
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
          collectionId: collectionId,
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
    required this.collectionId,
    required this.id,
    required this.locale,
  }) : super.internal();

  final String collectionId;
  final int id;
  final String locale;

  @override
  Override overrideWith(
    FutureOr<ItemModel> Function(LocalizedCollectionItemRef provider) create,
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
        collectionId: collectionId,
        id: id,
        locale: locale,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ItemModel> createElement() {
    return _LocalizedCollectionItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalizedCollectionItemProvider &&
        other.collectionId == collectionId &&
        other.id == id &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, locale.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocalizedCollectionItemRef on AutoDisposeFutureProviderRef<ItemModel> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `id` of this provider.
  int get id;

  /// The parameter `locale` of this provider.
  String get locale;
}

class _LocalizedCollectionItemProviderElement
    extends AutoDisposeFutureProviderElement<ItemModel>
    with LocalizedCollectionItemRef {
  _LocalizedCollectionItemProviderElement(super.provider);

  @override
  String get collectionId =>
      (origin as LocalizedCollectionItemProvider).collectionId;
  @override
  int get id => (origin as LocalizedCollectionItemProvider).id;
  @override
  String get locale => (origin as LocalizedCollectionItemProvider).locale;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
