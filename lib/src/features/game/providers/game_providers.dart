import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../constants/game_mode.dart';
import '../../../../router/router.dart';
import '../repository/game_repository.dart';

part 'game_providers.g.dart';

/// Provider for the GameService
@riverpod
GameRepository gameService(Ref ref) {
  return GameRepository();
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
