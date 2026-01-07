import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../../../shared/utils/extensions.dart';
import '../../controllers/game_controller.dart';
import '../../controllers/timer_controller.dart';
import '../../providers/game_providers.dart';

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
    final bool isUrgent = progress < 0.25;

    return Container(
      width: 64,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.slate200,
          width: 4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Symbols.timer,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            timerText,
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ).animate(target: isUrgent ? 1 : 0).shake(
          duration: const Duration(milliseconds: 500),
          hz: 4,
        );
  }
}
