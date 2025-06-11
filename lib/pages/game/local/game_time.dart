import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/game/game_session.dart';
import '../../../utils/extensions.dart';
import 'game_timer_provider.dart';

class GameTime extends ConsumerWidget {
  const GameTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode =
        switch (GoRouterState.of(context).uri.queryParameters['mode']) {
      'simple' => GameMode.simple,
      'research' => GameMode.research,
      _ => GameMode.simple,
    };

    final seconds = ref.watch(gameTimerProvider);
    final duration = Duration(seconds: seconds);
    final timerText =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

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
              backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(50),
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
    );
  }
}
