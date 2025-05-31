import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game/game_session.dart';
import '../../providers/collection/collection_providers.dart';
import '../../providers/game/game_providers.dart';
import 'local/game_timer_provider.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  FutureOr<GameSession> build(String cid, String gid, GameMode mode) async {
    ref.onDispose(() {
      // Cancel the timer when the controller is disposed
      ref.read(gameTimerProvider.notifier).cancelTimer();
    });

    final info = await ref.watch(collectionInfoProvider(cid).future);
    final gameService = ref.watch(gameServiceProvider);

    final itemIds = gameService.generateItemIds(
      gid: gid,
      collectionSize: info.size,
      rounds: 5,
    );

    final items =
        await ref.watch(collectionItemsByIdsProvider(info.id, itemIds).future);

    final session = gameService.createGameSession(
      mode: mode,
      items: items,
    );

    // Start the timer for the first round
    ref.read(gameTimerProvider.notifier).startTimer(
      session.roundDurationSeconds,
    );

    return session;
  }

  void onSubmit(double estimate) {
    final gameService = ref.watch(gameServiceProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }
    ref.read(gameTimerProvider.notifier).cancelTimer();
    update((state) => gameService.submitEstimate(
      session: state,
      estimate: estimate,
    ));
    
  }

  void onNextRound() {
    final gameService = ref.watch(gameServiceProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }
    update((state) => gameService.nextRound(state));
    // Restart the timer for the next round
    ref.read(gameTimerProvider.notifier).startTimer(
      state.value!.roundDurationSeconds
    );
  }
}
