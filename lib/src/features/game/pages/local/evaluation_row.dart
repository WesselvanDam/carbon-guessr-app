import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../controllers/game_controller.dart';
import '../../controllers/ratio_controller.dart';
import '../../controllers/timer_controller.dart';

class EvaluationRow extends ConsumerStatefulWidget {
  const EvaluationRow({super.key});

  @override
  ConsumerState<EvaluationRow> createState() => _EvaluationRowState();
}

class _EvaluationRowState extends ConsumerState<EvaluationRow> {
  int decimals(double ratio) {
    if (ratio > 100) return 0;
    if (ratio > 10) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final currentRound = ref.watch(
      gameControllerProvider.select((game) => game.value?.currentRound),
    );

    final isRoundOver = ref.watch(
      timerControllerProvider.select((time) => time == 0),
    );

    final ratio = ref.watch(ratioControllerProvider);

    // Show different UI when round is over
    if (isRoundOver && currentRound != null) {
      final score = currentRound.score?.round() ?? 0;
      final correctRatio = currentRound.correctRatio;
      final userEstimate = currentRound.userEstimate ?? ratio;

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
                      fontWeight: FontWeight.w900,
                      color: AppColors.text,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      '/100',
                      style: AppTypography.h4.copyWith(
                        color: AppColors.slate400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ACCURACY SCORE',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.slate400,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 24),
          // Ratio comparison
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0x332563EB), // primary with 20% opacity
                        width: 4,
                      ),
                      top: BorderSide(color: AppColors.slate200),
                      left: BorderSide(color: AppColors.slate200),
                      right: BorderSide(color: AppColors.slate200),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'YOUR ESTIMATE',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            userEstimate >= 1
                                ? userEstimate.toStringAsFixed(decimals(userEstimate))
                                : '1',
                            style: AppTypography.h2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            ' : ',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.slate300,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            userEstimate >= 1
                                ? '1'
                                : (1 / userEstimate).toStringAsFixed(
                                    decimals(1 / userEstimate),
                                  ),
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.slate300,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.1, end: 0),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7), // green-50
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0xFFBBF7D0), // green-200
                        width: 4,
                      ),
                      top: BorderSide(color: Color(0xFFBBF7D0)),
                      left: BorderSide(color: Color(0xFFBBF7D0)),
                      right: BorderSide(color: Color(0xFFBBF7D0)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E), // green-500
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'TRUE RATIO',
                            style: AppTypography.labelSmall.copyWith(
                              color: const Color(0xFF15803D), // green-700
                              fontSize: 9,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Symbols.check_circle,
                            size: 10,
                            color: Color(0xFF15803D),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            correctRatio >= 1
                                ? correctRatio.toStringAsFixed(decimals(correctRatio))
                                : '1',
                            style: AppTypography.h2.copyWith(
                              color: const Color(0xFF16A34A), // green-600
                            ),
                          ),
                          Text(
                            ' : ',
                            style: AppTypography.bodyLarge.copyWith(
                              color: const Color(0xFF86EFAC), // green-300
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            correctRatio >= 1
                                ? '1'
                                : (1 / correctRatio).toStringAsFixed(
                                    decimals(1 / correctRatio),
                                  ),
                            style: AppTypography.bodyLarge.copyWith(
                              color: const Color(0xFF86EFAC), // green-300
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 900.ms).slideX(begin: 0.1, end: 0),
              ),
            ],
          ),
        ],
      );
    }

    // Show current ratio while playing
    return Center(
      child: Column(
        children: [
          Text(
            'CURRENT RATIO',
            style: AppTypography.caption.copyWith(
              color: AppColors.slate400,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  ratio >= 1
                      ? ratio.toStringAsFixed(decimals(ratio))
                      : '1',
                  style: AppTypography.h1.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  ' : ',
                  style: AppTypography.h4.copyWith(
                    color: AppColors.slate300,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ratio >= 1
                      ? '1'
                      : (1 / ratio).toStringAsFixed(decimals(1 / ratio)),
                  style: AppTypography.h4.copyWith(
                    color: AppColors.slate300,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
