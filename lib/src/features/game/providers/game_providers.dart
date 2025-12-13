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
    routerProvider.select((router) {
      final gid = router.state.pathParameters['gid'];
      return gid ?? '';
    }),
  );
}

@riverpod
GameMode gameMode(Ref ref) {
  return ref.watch(
    routerProvider.select((router) {
      final mode = router.state.uri.queryParameters['mode'];
      return GameMode.values.byName(mode ?? GameMode.simple.name);
    }),
  );
}

@riverpod
double minRatio(Ref ref) {
  final ratioBoundary =
      ref.watch(currentCollectionProvider).value?.ratioBoundary ?? 0.01;

  return pow(10, (log(ratioBoundary) / log(10)).floor()).toDouble();
}
