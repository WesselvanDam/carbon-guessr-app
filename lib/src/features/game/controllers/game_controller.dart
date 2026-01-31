import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../constants/game_mode.dart';
import '../../collection/providers/current_collection.dart';
import '../../stats/providers/stats.dart';
import '../models/game.model.dart';
import '../providers/game_providers.dart';
import '../providers/items.dart';
import '../repository/game_repository.dart';
import 'ratio_controller.dart';
import 'timer_controller.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  FutureOr<GameModel> build() async {
    final collection = await ref.watch(currentCollectionProvider.future);
    final gid = ref.watch(gameIdProvider);

    final gameRepository = ref.watch(gameRepositoryProvider);

    final itemIds = gameRepository.generateItemIds(
      gid: gid,
      collectionSize: collection.size,
      rounds: 5,
    );

    final items = await ref
        .read(itemsProvider(collection.id).notifier)
        .getItems(itemIds);

    final session = gameRepository.createGameSession(items: items);

    return session;
  }

  void onSubmit() {
    final gameRepository = ref.read(gameRepositoryProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }

    ref.read(timerControllerProvider.notifier).stop();

    final ratio = ref.read(ratioControllerProvider);
    final ratioBoundary = ref.read(minRatioProvider);

    update(
      (state) => gameRepository.submitEstimate(
        game: state,
        estimate: ratio,
        ratioBoundary: ratioBoundary,
      ),
    );
  }

  Future<void> onNextRound() async {
    final gameRepository = ref.watch(gameRepositoryProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }

    ref.read(ratioControllerProvider.notifier).reset();

    final updatedGame = gameRepository.nextRound(state.value!);

    // Check if the game is now completed. Update stats if so and mode is simple.
    if (updatedGame.isCompleted) {
      final mode = ref.read(gameModeProvider);
      if (mode == GameMode.simple) {
        final cid = ref.read(currentCollectionProvider).requireValue.id;
        final totalScore = updatedGame.totalScore;

        await ref.read(statsProvider.notifier).updateStats(cid, totalScore);
      }
    }

    update((state) => updatedGame);
  }
}
