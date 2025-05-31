// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameControllerHash() => r'000136f5101a788e41fd06665ac1eb32ad717c14';

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

abstract class _$GameController
    extends BuildlessAutoDisposeAsyncNotifier<GameSession> {
  late final String cid;
  late final String gid;
  late final GameMode mode;

  FutureOr<GameSession> build(
    String cid,
    String gid,
    GameMode mode,
  );
}

/// See also [GameController].
@ProviderFor(GameController)
const gameControllerProvider = GameControllerFamily();

/// See also [GameController].
class GameControllerFamily extends Family<AsyncValue<GameSession>> {
  /// See also [GameController].
  const GameControllerFamily();

  /// See also [GameController].
  GameControllerProvider call(
    String cid,
    String gid,
    GameMode mode,
  ) {
    return GameControllerProvider(
      cid,
      gid,
      mode,
    );
  }

  @override
  GameControllerProvider getProviderOverride(
    covariant GameControllerProvider provider,
  ) {
    return call(
      provider.cid,
      provider.gid,
      provider.mode,
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
  String? get name => r'gameControllerProvider';
}

/// See also [GameController].
class GameControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GameController, GameSession> {
  /// See also [GameController].
  GameControllerProvider(
    String cid,
    String gid,
    GameMode mode,
  ) : this._internal(
          () => GameController()
            ..cid = cid
            ..gid = gid
            ..mode = mode,
          from: gameControllerProvider,
          name: r'gameControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameControllerHash,
          dependencies: GameControllerFamily._dependencies,
          allTransitiveDependencies:
              GameControllerFamily._allTransitiveDependencies,
          cid: cid,
          gid: gid,
          mode: mode,
        );

  GameControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cid,
    required this.gid,
    required this.mode,
  }) : super.internal();

  final String cid;
  final String gid;
  final GameMode mode;

  @override
  FutureOr<GameSession> runNotifierBuild(
    covariant GameController notifier,
  ) {
    return notifier.build(
      cid,
      gid,
      mode,
    );
  }

  @override
  Override overrideWith(GameController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameControllerProvider._internal(
        () => create()
          ..cid = cid
          ..gid = gid
          ..mode = mode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cid: cid,
        gid: gid,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GameController, GameSession>
      createElement() {
    return _GameControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameControllerProvider &&
        other.cid == cid &&
        other.gid == gid &&
        other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cid.hashCode);
    hash = _SystemHash.combine(hash, gid.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GameControllerRef on AutoDisposeAsyncNotifierProviderRef<GameSession> {
  /// The parameter `cid` of this provider.
  String get cid;

  /// The parameter `gid` of this provider.
  String get gid;

  /// The parameter `mode` of this provider.
  GameMode get mode;
}

class _GameControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GameController, GameSession>
    with GameControllerRef {
  _GameControllerProviderElement(super.provider);

  @override
  String get cid => (origin as GameControllerProvider).cid;
  @override
  String get gid => (origin as GameControllerProvider).gid;
  @override
  GameMode get mode => (origin as GameControllerProvider).mode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
