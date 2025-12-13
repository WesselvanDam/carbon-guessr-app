import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../collection/providers/current_collection.dart';
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
        .getItemsByIds(itemIds);

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

  void onNextRound() {
    final gameRepository = ref.watch(gameRepositoryProvider);
    if (!state.hasValue || state.value == null) {
      return;
    }

    ref.read(ratioControllerProvider.notifier).reset();

    update((state) => gameRepository.nextRound(state));
  }
}
