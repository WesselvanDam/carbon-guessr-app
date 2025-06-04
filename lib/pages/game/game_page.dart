import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_session.dart';
import 'game_controller.dart';
import 'game_results_page.dart';
import 'local/game_round_form.dart';
import 'local/game_time.dart';

class GamePage extends ConsumerWidget {
  const GamePage(
      {required this.cid, required this.gid, required this.mode, super.key});

  final String cid;
  final String gid;
  final GameMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameControllerProvider(cid, gid, mode));
    if (session.isLoading || session.value == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }

    final gameSession = session.value!;
    debugPrint(
        'Indices of completed rounds: ${gameSession.rounds.asMap().entries.where((entry) => entry.value.isCompleted).map((entry) => entry.key).toList()}');

    if (gameSession.isCompleted) {
      return GameResultsPage(session: gameSession);
    }

    void onSubmit(double estimate) {
      ref
          .read(gameControllerProvider(cid, gid, mode).notifier)
          .onSubmit(estimate);
    }

    void onNextRound() {
      ref.read(gameControllerProvider(cid, gid, mode).notifier).onNextRound();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton.outlined(
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
        title: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Round ${gameSession.currentRoundIndex + 1} of ${gameSession.rounds.length}'),
            Text(
              'Carbon Footprints · ${mode.name} Mode',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          GameTime(),
        ],
      ),
      body: SingleChildScrollView(
        child: GameRoundForm(
          round: gameSession.rounds[gameSession.currentRoundIndex],
          onSubmit: onSubmit,
          onNextRound: onNextRound,
        ),
      ),
    );
  }
}
