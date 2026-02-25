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

    final score = ref.watch(
      gameControllerProvider.select(
        (game) => game.value?.currentRound.score ?? 0,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        final halfWidth = fullWidth / 2;
        final scoreWidth = isRoundOver ? halfWidth : 0.0;
        final buttonWidth = isRoundOver ? halfWidth : fullWidth;

        return Row(
          crossAxisAlignment: .start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: scoreWidth,
              child: !isRoundOver
                  ? const SizedBox.shrink()
                  : Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$score',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 56,
                                fontVariations: [FontVariation('wght', 900)],
                                color: AppColors.neutral900,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                'PTS',
                                style: AppTypography.h4.copyWith(
                                  color: AppColors.neutral400,
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate(target: isRoundOver ? 1 : 0)
                        .fadeIn()
                        .slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuad),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: buttonWidth,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                alignment: isRoundOver
                    ? Alignment.centerRight
                    : Alignment.center,
                child: isRoundOver
                    ? ActionButton.secondary(
                        key: const ValueKey('button'),
                        onPressed: () => _nextRound(ref),
                        label: isLastRound ? 'Finish' : 'Next',
                        showArrow: true,
                        fullWidth: true,
                      )
                    : ActionButton.primary(
                        key: const ValueKey('button'),
                        onPressed: () => _submitEstimate(ref),
                        label: 'Submit',
                        showArrow: true,
                        fullWidth: true,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
