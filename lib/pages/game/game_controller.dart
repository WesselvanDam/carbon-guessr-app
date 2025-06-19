import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game/game.model.dart';
import '../../providers/collection/collection_providers.dart';
import '../../providers/game/game_providers.dart';
import 'local/ratio_controller.dart';
import 'local/timer_controller.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  late final double ratioBoundary;

  @override
  FutureOr<GameModel> build() async {
    final collection = (await ref.watch(currentCollectionProvider.future))!;
    final gid = ref.watch(gameIdProvider);

    // Set the ratio boundary based on the collection's metadata
    ratioBoundary = collection.ratioBoundary;

    final gameService = ref.watch(gameServiceProvider);

    final itemIds = gameService.generateItemIds(
      gid: gid,
      collectionSize: collection.size,
      rounds: 5,
    );

    final items =
        await ref.watch(collectionItemsByIdsProvider(collection.id, itemIds).future);

    final session = gameService.createGameSession(items: items);

    return session;
  }

  void onSubmit() {
    final gameService = ref.watch(gameServiceProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }

    // Cancel the timer
    ref.read(timerControllerProvider.notifier).cancel();

    // Get the current estimate from the ratio controller
    final ratio = ref.read(ratioControllerProvider);

    // Submit the estimate
    update((state) => gameService.submitEstimate(
          game: state,
          estimate: ratio,
          ratioBoundary: ratioBoundary,
        ));
  }

  void onNextRound() {
    final gameService = ref.watch(gameServiceProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }
    update((state) => gameService.nextRound(state));
  }
}
