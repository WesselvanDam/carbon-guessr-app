import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../design_system/components/buttons/action_button.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../controllers/game_controller.dart';
import '../controllers/timer_controller.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  void _submitEstimate(WidgetRef ref) {
    ref.read(gameControllerProvider.notifier).onSubmit();
  }

  void _nextRound(WidgetRef ref) {
    ref.read(gameControllerProvider.notifier).onNextRound();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRoundOver = ref.watch(
      timerControllerProvider.select((state) => state == 0),
    );
    final isLastRound = ref.watch(
      gameControllerProvider.select(
        (state) =>
            state.value?.currentRoundIndex ==
            (state.value?.rounds.length ?? 0) - 1,
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Row(
        children: [
          Flexible(child: _afterRoundUi(context, ref, isRoundOver)),
          if (isRoundOver)
            Flexible(
              child: ActionButton.secondary(
                key: const ValueKey('button'),
                onPressed: () => _nextRound(ref),
                label: isLastRound ? 'Finish Game' : 'Next Round',
                showArrow: true,
                fullWidth: true,
              ),
            )
          else
            Flexible(
              child: ActionButton.primary(
                key: const ValueKey('button'),
                onPressed: () => _submitEstimate(ref),
                label: 'Submit Answer',
                showArrow: true,
                fullWidth: true,
              ),
            ),
        ],
      ),
    );
  }

  Widget _afterRoundUi(BuildContext context, WidgetRef ref, bool isRoundOver) {
    final score = ref.watch(
      gameControllerProvider.select(
        (game) => game.value?.currentRound.score ?? 0,
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: !isRoundOver
          ? const SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$score',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 60,
                    fontVariations: [
                      FontVariation('wght', 900), // Black weight
                    ],
                    color: AppColors.neutral900,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    '/100',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
    );
  }
}
