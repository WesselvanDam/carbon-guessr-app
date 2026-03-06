import 'dart:convert';

import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../client/local_db.dart';
import '../models/stats.model.dart';

part 'stats.g.dart';

@riverpod
class Stats extends _$Stats {
  @override
  FutureOr<Map<String, StatsModel>> build() async {
    await persist(
      ref.watch(localDbClientProvider.future),
      key: 'stats',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: jsonEncode,
      decode: (String encoded) {
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;
        return decoded.map(
          (key, value) =>
              MapEntry(key, StatsModel.fromJson(value as Map<String, dynamic>)),
        );
      },
    ).future;
    return state.value ?? {};
  }

  Future<void> updateStats(String cid, int gameScore) async {
    final current = state.value ?? {};
    final stats = current[cid] ?? const StatsModel();

    state = AsyncValue.data({
      ...current,
      cid: stats.copyWith(
        gamesFinished: stats.gamesFinished + 1,
        // Only store the final 30 scores to prevent unbounded growth
        recentGameScores: [
          gameScore,
          ...stats.recentGameScores,
        ].take(30).toList(),
      ),
    });
  }
}
