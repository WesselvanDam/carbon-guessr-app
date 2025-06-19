import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/game/game_providers.dart';
import '../../../utils/extensions.dart';
import '../game_controller.dart';
import 'timer_controller.dart';

class GameTime extends ConsumerWidget {
  const GameTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        gameControllerProvider.select((game) =>
            (game.value?.isCompleted ?? false)
                ? null
                : game.value?.currentRoundIndex), (previous, next) {
      // Start the timer when the round index changes
      if (next != null) {
        ref.read(timerControllerProvider.notifier).start();
      }
    });

    final seconds = ref.watch(timerControllerProvider);

    if (seconds == null || seconds <= 0) {
      return const SizedBox.shrink();
    }

    final duration = Duration(seconds: seconds);
    final timerText =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final mode = ref.watch(gameModeProvider);
    final progress = seconds / mode.roundDurationInSeconds;

    // Use different colors based on remaining time
    final Color timerColor = switch (progress) {
      < 0.25 => Colors.redAccent,
      < 0.5 => Colors.orangeAccent,
      _ => Colors.greenAccent,
    };

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 52,
        height: 52,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 2,
              color: timerColor,
              backgroundColor:
                  Theme.of(context).colorScheme.onSurface.withAlpha(50),
              constraints: const BoxConstraints.expand(
                width: 52 - 2, // Adjust for stroke width
                height: 52 - 2,
              ),
            ),
            Text(
              timerText,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: timerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}
