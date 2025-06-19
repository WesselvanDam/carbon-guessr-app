import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/collection/collection_providers.dart';
import '../../../providers/game/game_providers.dart';
import '../../../utils/extensions.dart';
import '../game_controller.dart';
import 'game_time.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 68,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton.outlined(
          padding: const EdgeInsets.all(12.0),
          iconSize: 28,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            side: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                width: 2),
          ),
        ),
      ),
      title: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(builder: (context, ref, _) {
            final game = ref.watch(gameControllerProvider).valueOrNull;
            return Text((game?.isCompleted ?? false)
                ? 'Game Completed!'
                : 'Round ${(game?.currentRoundIndex ?? 0) + 1} of ${game?.rounds.length ?? 5}');
          }),
          Consumer(builder: (context, ref, _) {
            final collection = ref.watch(currentCollectionProvider);
            final mode = ref.watch(gameModeProvider);
            return Text(
              '${collection.value?.title.toTitleCase()} · ${mode.name.toTitleCase()} Mode',
              style: Theme.of(context).textTheme.bodySmall,
            );
          }),
        ],
      ),
      centerTitle: true,
      actions: const [
        GameTime(),
      ],
    );
  }
}
