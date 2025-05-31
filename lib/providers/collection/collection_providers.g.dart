// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectionServiceHash() => r'33c5db503f15517b0b33f32bdcc992245fc4676e';

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
class CollectionServiceFamily extends Family<CollectionService> {
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
class CollectionServiceProvider extends AutoDisposeProvider<CollectionService> {
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
    CollectionService Function(CollectionServiceRef provider) create,
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
  AutoDisposeProviderElement<CollectionService> createElement() {
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
mixin CollectionServiceRef on AutoDisposeProviderRef<CollectionService> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;
}

class _CollectionServiceProviderElement
    extends AutoDisposeProviderElement<CollectionService>
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

String _$collectionsInfoHash() => r'd01693dcbd9e5b3d2253896f7e5f2fd9c04f1d96';

/// See also [collectionsInfo].
@ProviderFor(collectionsInfo)
final collectionsInfoProvider = FutureProvider<List<CollectionInfo>>.internal(
  collectionsInfo,
  name: r'collectionsInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$collectionsInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CollectionsInfoRef = FutureProviderRef<List<CollectionInfo>>;
String _$collectionInfoHash() => r'85cfb4368a25b0ca3a151dd3abd82a64ebbcd4b8';

/// Provider for the collection info
///
/// Copied from [collectionInfo].
@ProviderFor(collectionInfo)
const collectionInfoProvider = CollectionInfoFamily();

/// Provider for the collection info
///
/// Copied from [collectionInfo].
class CollectionInfoFamily extends Family<AsyncValue<CollectionInfo>> {
  /// Provider for the collection info
  ///
  /// Copied from [collectionInfo].
  const CollectionInfoFamily();

  /// Provider for the collection info
  ///
  /// Copied from [collectionInfo].
  CollectionInfoProvider call(
    String collectionId,
  ) {
    return CollectionInfoProvider(
      collectionId,
    );
  }

  @override
  CollectionInfoProvider getProviderOverride(
    covariant CollectionInfoProvider provider,
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
  String? get name => r'collectionInfoProvider';
}

/// Provider for the collection info
///
/// Copied from [collectionInfo].
class CollectionInfoProvider extends AutoDisposeFutureProvider<CollectionInfo> {
  /// Provider for the collection info
  ///
  /// Copied from [collectionInfo].
  CollectionInfoProvider(
    String collectionId,
  ) : this._internal(
          (ref) => collectionInfo(
            ref as CollectionInfoRef,
            collectionId,
          ),
          from: collectionInfoProvider,
          name: r'collectionInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionInfoHash,
          dependencies: CollectionInfoFamily._dependencies,
          allTransitiveDependencies:
              CollectionInfoFamily._allTransitiveDependencies,
          collectionId: collectionId,
        );

  CollectionInfoProvider._internal(
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
    FutureOr<CollectionInfo> Function(CollectionInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionInfoProvider._internal(
        (ref) => create(ref as CollectionInfoRef),
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
  AutoDisposeFutureProviderElement<CollectionInfo> createElement() {
    return _CollectionInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionInfoProvider &&
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
mixin CollectionInfoRef on AutoDisposeFutureProviderRef<CollectionInfo> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;
}

class _CollectionInfoProviderElement
    extends AutoDisposeFutureProviderElement<CollectionInfo>
    with CollectionInfoRef {
  _CollectionInfoProviderElement(super.provider);

  @override
  String get collectionId => (origin as CollectionInfoProvider).collectionId;
}

String _$collectionItemHash() => r'c04fa485f8996a08e41bb2a059d45051294023de';

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
class CollectionItemProvider extends AutoDisposeFutureProvider<CollectionItem> {
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
        collectionId: collectionId,
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
mixin CollectionItemRef on AutoDisposeFutureProviderRef<CollectionItem> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `id` of this provider.
  int get id;
}

class _CollectionItemProviderElement
    extends AutoDisposeFutureProviderElement<CollectionItem>
    with CollectionItemRef {
  _CollectionItemProviderElement(super.provider);

  @override
  String get collectionId => (origin as CollectionItemProvider).collectionId;
  @override
  int get id => (origin as CollectionItemProvider).id;
}

String _$collectionItemsByIdsHash() =>
    r'b3ad422c3c3f7aeffefd673fc6bd856e83a3e4c9';

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
    extends AutoDisposeFutureProvider<List<CollectionItem>> {
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
        collectionId: collectionId,
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
mixin CollectionItemsByIdsRef
    on AutoDisposeFutureProviderRef<List<CollectionItem>> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

  /// The parameter `ids` of this provider.
  List<int> get ids;
}

class _CollectionItemsByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<CollectionItem>>
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
    r'244d2e7b74c42fa6c457cdf28613d1a6f40eb716';

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
    extends AutoDisposeFutureProvider<CollectionItem> {
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
        collectionId: collectionId,
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
mixin LocalizedCollectionItemRef
    on AutoDisposeFutureProviderRef<CollectionItem> {
  /// The parameter `collectionId` of this provider.
  String get collectionId;

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
  String get collectionId =>
      (origin as LocalizedCollectionItemProvider).collectionId;
  @override
  int get id => (origin as LocalizedCollectionItemProvider).id;
  @override
  String get locale => (origin as LocalizedCollectionItemProvider).locale;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
