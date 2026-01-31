import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../collection/providers/current_collection.dart';

import '../controllers/game_controller.dart';
import '../controllers/timer_controller.dart';
import 'local/evaluation_row.dart';

class RoundHeader extends ConsumerWidget {
  const RoundHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRoundOver = ref.watch(
      timerControllerProvider.select((time) => time == 0),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        Flexible(
          child: Center(
            child: isRoundOver
                ? _afterRoundUi(context, ref)
                : _duringRoundUi(context, ref),
          ),
        ),
        const EvaluationRow(),
      ],
    );
  }

  Widget _duringRoundUi(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Compare the Footprint',
          style: AppTypography.h3.copyWith(color: AppColors.neutral900),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Drag the blue square to estimate how many times more ${collection?.quantity ?? 'CO2eq'} one item produces compared to the other.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _afterRoundUi(BuildContext context, WidgetRef ref) {
    final score = ref.watch(
      gameControllerProvider.select(
        (game) => game.value?.currentRound.score ?? 0,
      ),
    );

    return Column(
      children: [
        // Score badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: score >= 80
                ? const Color(0xFFFEF3C7) // yellow-100
                : score >= 60
                ? const Color(0xFFDCFCE7) // green-100
                : const Color(0xFFFEE2E2), // red-100
            border: Border.all(
              color: score >= 80
                  ? const Color(0xFFFDE047) // yellow-200
                  : score >= 60
                  ? const Color(0xFF86EFAC) // green-200
                  : const Color(0xFFFECACA), // red-200
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Symbols.emoji_events,
                size: 14,
                color: score >= 80
                    ? const Color(0xFFCA8A04) // yellow-700
                    : score >= 60
                    ? const Color(0xFF15803D) // green-700
                    : const Color(0xFFB91C1C), // red-700
              ),
              const SizedBox(width: 4),
              Text(
                score >= 80
                    ? 'Great Estimation!'
                    : score >= 60
                    ? 'Good Try!'
                    : 'Keep Practicing!',
                style: AppTypography.labelSmall.copyWith(
                  color: score >= 80
                      ? const Color(0xFFCA8A04)
                      : score >= 60
                      ? const Color(0xFF15803D)
                      : const Color(0xFFB91C1C),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms),
        const SizedBox(height: 16),
        // Score display
        Column(
          children: [
            Row(
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
            ),
          ],
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }
}
