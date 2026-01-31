import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../controllers/game_controller.dart';
import '../../controllers/ratio_controller.dart';
import '../../controllers/timer_controller.dart';

int _decimals(double ratio) {
  if (ratio > 100) return 0;
  if (ratio > 10) return 1;
  return 2;
}

class RatioDisplayCard extends StatelessWidget {
  const RatioDisplayCard({
    required this.ratio,
    required this.label,
    super.key,
    this.isTrueRatio = false,
    this.animationDelay = 0,
  });
  final double ratio;
  final String label;
  final bool isTrueRatio;
  final int animationDelay;

  @override
  Widget build(BuildContext context) {
    final primaryColor = isTrueRatio
        ? const Color(0xFF15803D)
        : AppColors.primary600;
    final borderColor = isTrueRatio
        ? const Color(0xFFBBF7D0)
        : AppColors.neutral200;
    final topBarColor = isTrueRatio ? AppColors.green500 : AppColors.primary600;
    const largeTextStyle = AppTypography.h2;
    const smallTextStyle = AppTypography.h4;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(color: topBarColor),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(color: primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    ratio >= 1 ? ratio.toStringAsFixed(_decimals(ratio)) : '1',
                    style: (ratio >= 1 ? largeTextStyle : smallTextStyle)
                        .copyWith(color: AppColors.primary600),
                  ),
                  Text(
                    ' : ',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.neutral300,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ratio >= 1
                        ? '1'
                        : (1 / ratio).toStringAsFixed(_decimals(1 / ratio)),
                    style: (ratio >= 1 ? smallTextStyle : largeTextStyle)
                        .copyWith(color: AppColors.accent600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EvaluationRow extends ConsumerWidget {
  const EvaluationRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRound = ref.watch(
      gameControllerProvider.select((game) => game.value?.currentRound),
    );

    final isRoundOver = ref.watch(
      timerControllerProvider.select((time) => time == 0),
    );

    final ratio = ref.watch(ratioControllerProvider);

    // Show different UI when round is over
    final userEstimate = currentRound?.userEstimate ?? ratio;
    final correctRatio = currentRound?.correctRatio ?? 1;

    return Column(
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: RatioDisplayCard(
                ratio: userEstimate,
                label: 'YOUR ESTIMATE',
                animationDelay: 700,
              ),
            ),
            if (isRoundOver)
              Expanded(
                child: RatioDisplayCard(
                  ratio: correctRatio,
                  label: 'TRUE RATIO',
                  isTrueRatio: true,
                  animationDelay: 900,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
