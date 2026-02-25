import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../shared/widgets/ratio_text.dart';
import '../../collection/providers/current_collection.dart';
import '../controllers/game_controller.dart';
import '../controllers/ratio_controller.dart';
import '../controllers/timer_controller.dart';
import '../models/round.model.dart';
import '../widgets/item_tile.dart';

class RoundHeader extends ConsumerWidget {
  const RoundHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRound = ref.watch(
      gameControllerProvider.select((game) => game.value?.currentRound),
    );

    return Column(
      children: [
        _duringRoundUi(context, ref),
        const SizedBox(height: 8),
        ItemTile(isFirst: true, context: context, round: currentRound),
        ItemTile(isFirst: false, context: context, round: currentRound),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _duringRoundUi(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider).value;
    final baseStyle = AppTypography.bodyLarge.copyWith(
      color: AppColors.neutral500,
      fontVariations: [
        const FontVariation('wght', 600), // Medium weight
      ],
    );

    return Text.rich(
      TextSpan(
        text: 'Compare the ratio in ',
        children: [
          TextSpan(
            text: collection?.quantity ?? '',
            style: baseStyle.copyWith(
              color: AppColors.neutral900,
              fontVariations: [
                const FontVariation('wght', 700), // Bold weight
              ],
            ),
          ),
          const TextSpan(text: ' (expressed in '),
          TextSpan(
            text: collection?.unit ?? '',
            style: baseStyle.copyWith(
              color: AppColors.neutral900,
              fontVariations: [
                const FontVariation('wght', 700), // Bold weight
              ],
            ),
          ),
          const TextSpan(text: ') between the two items.'),
        ],
      ),
      style: baseStyle,
    );
  }
}

class EvaluationRow extends ConsumerWidget {
  const EvaluationRow({super.key, this.round});

  final RoundModel? round;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRoundOver = ref.watch(
      timerControllerProvider.select((time) => time == 0),
    );

    final ratio = ref.watch(ratioControllerProvider);

    final currentRound =
        round ??
        ref.watch(
          gameControllerProvider.select((game) => game.value?.currentRound),
        );

    // Show different UI when round is over
    final correctRatio = currentRound?.correctRatio ?? 1;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'YOUR GUESS',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.neutral400,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              RatioText(
                ratio: isRoundOver ? currentRound?.userEstimate : ratio,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Container(width: 1, height: 32, color: AppColors.neutral200),
        Expanded(
          child: Column(
            children: [
              Text(
                'TRUE RATIO',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.neutral400,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              ImageFiltered(
                enabled: !isRoundOver,
                imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: RatioText(
                  ratio: isRoundOver ? correctRatio : 1,
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
