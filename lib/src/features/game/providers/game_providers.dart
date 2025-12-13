import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../constants/game_mode.dart';
import '../../../../router/router.dart';
import '../../collection/providers/current_collection.dart';

part 'game_providers.g.dart';

@riverpod
String gameId(Ref ref) {
  return ref.watch(
    routerProvider.select((router) => router.state.pathParameters['gid'] ?? ''),
  );
}

@riverpod
GameMode gameMode(Ref ref) {
  final mode = ref.watch(
    routerProvider.select(
      (router) => GameMode.values.byName(
        router.state.uri.queryParameters['mode'] ?? GameMode.simple.name,
      ),
    ),
  );
  return mode;
}

@riverpod
double minRatio(Ref ref) {
  final ratioBoundary =
      ref.watch(currentCollectionProvider).value?.ratioBoundary ?? 0.01;

  return pow(10, (log(ratioBoundary) / log(10)).floor()).toDouble();
}
