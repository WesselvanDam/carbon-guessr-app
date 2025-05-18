// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameServiceHash() => r'8abf4472ef1930f357c6eb7893d3936bdab39a9f';

/// Provider for the GameService
///
/// Copied from [gameService].
@ProviderFor(gameService)
final gameServiceProvider = AutoDisposeProvider<GameService>.internal(
  gameService,
  name: r'gameServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameServiceRef = AutoDisposeProviderRef<GameService>;
String _$gameSessionNotifierHash() =>
    r'e74f5aad5ccb97f59e9154e19a42e4c18a7d0c03';

/// Provider for the active game session
///
/// Copied from [GameSessionNotifier].
@ProviderFor(GameSessionNotifier)
final gameSessionNotifierProvider =
    NotifierProvider<GameSessionNotifier, GameSession?>.internal(
  GameSessionNotifier.new,
  name: r'gameSessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameSessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameSessionNotifier = Notifier<GameSession?>;
String _$gameTimerNotifierHash() => r'1d4605bb2624b9d55f371a00fdfcb9ff7094cb58';

/// Provider for the game timer
///
/// Copied from [GameTimerNotifier].
@ProviderFor(GameTimerNotifier)
final gameTimerNotifierProvider =
    AutoDisposeNotifierProvider<GameTimerNotifier, int>.internal(
  GameTimerNotifier.new,
  name: r'gameTimerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameTimerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameTimerNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
