
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design_system/styles/app_colors.dart';
import '../../design_system/styles/app_typography.dart';

class StatBox extends ConsumerWidget {
  const StatBox({
    required this.score,
    required this.label,
    this.maxScore,
  });

  final int? score;
  final int? maxScore;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (score == null) {
      return const SizedBox.shrink();
    }

    // Calculate progress and color
    final progress = maxScore != null
        ? (score! / maxScore!).clamp(0.0, 1.0)
        : 1.0;
    final percentage = progress * 100;

    final (Color progressColor, Color trackColor) = maxScore == null
        ? (AppColors.neutral500, AppColors.neutral100)
        : switch (percentage) {
            < 50 => (AppColors.error500, AppColors.error100),
            < 80 => (AppColors.warning500, AppColors.warning100),
            _ => (AppColors.success500, AppColors.success100),
          };

    return Column(
      spacing: 6,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            children: [
              CircularProgressIndicator(
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                strokeAlign: -1,
                value: progress,
                strokeWidth: 4,
                color: progressColor,
                backgroundColor: trackColor,
                trackGap: 4,
                strokeCap: StrokeCap.round,
              ),
              // Score display
              Center(
                child: Text(
                  score.toString().toUpperCase(),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.neutral900,
                    fontVariations: const [FontVariation('wght', 800)],
                  ),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60),
          child: Text(
            label,
            textAlign: TextAlign.center,
            softWrap: true,
            style: AppTypography.captionMedium.copyWith(
              color: AppColors.neutral500,
            ),
          ),
        ),
      ],
    );
  }
}
