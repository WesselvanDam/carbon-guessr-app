import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game/game.model.dart';
import '../../router/router.dart';
import '../../services/game/game_service.dart';

part 'game_providers.g.dart';

/// Provider for the GameService
@riverpod
GameService gameService(Ref ref) {
  return GameService();
}

@riverpod
String gameId(Ref ref) {
  return ref.watch(routerProvider.select(
    (router) => router.state.pathParameters['gid'] ?? '',
  ));
}

@riverpod
GameMode gameMode(Ref ref) {
  final mode = ref.watch(routerProvider.select(
    (router) => GameMode.values.byName(
      router.state.uri.queryParameters['mode'] ?? GameMode.simple.name,
    ),
  ));
  return mode;
}
