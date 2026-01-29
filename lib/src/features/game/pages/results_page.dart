import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../data/models/item.model.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/chips/info_chip.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_shadows.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../design_system/components/buttons/action_button.dart';
import '../../collection/providers/current_collection.dart';
import '../controllers/game_controller.dart';
import '../models/game.model.dart';
import '../models/round.model.dart';
import '../providers/game_providers.dart';
import '../repository/game_repository.dart';
import 'local/item_details_dialog.dart';

class GameResultsPage extends ConsumerWidget {
  const GameResultsPage({super.key});

  int _decimals(double ratio) {
    if (ratio > 100) return 0;
    if (ratio > 10) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value!;

    final totalScore = game.totalScore;
    final maxPossibleScore = game.rounds.length * 100.0;
    final scorePercentage = ((totalScore / maxPossibleScore) * 100).round();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Score circle
                Container(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary700.withAlpha(50),
                            offset: const Offset(0, 10),
                            blurRadius: 40,
                            spreadRadius: -10,
                          ),
                        ],
                        border: Border.all(color: AppColors.neutral100),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'FINAL SCORE',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary600,
                              letterSpacing: 2,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 24, width: double.infinity),
                          SizedBox(
                            width: 192,
                            height: 192,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background circle
                                const SizedBox(
                                  width: 192,
                                  height: 192,
                                  child: CircularProgressIndicator(
                                    value: 1.0,
                                    strokeWidth: 16,
                                    color: AppColors.neutral100,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                // Progress circle
                                SizedBox(
                                  width: 192,
                                  height: 192,
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: scorePercentage / 100,
                                    ),
                                    duration: const Duration(
                                      milliseconds: 1500,
                                    ),
                                    curve: Curves.easeOut,
                                    builder: (context, value, child) {
                                      return CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 16,
                                        strokeCap: StrokeCap.round,
                                        color: AppColors.primary600,
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                  ),
                                ),
                                // Score text
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$totalScore',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 72,
                                        fontVariations: [
                                          FontVariation(
                                            'wght',
                                            900,
                                          ), // Black weight
                                        ],
                                        color: AppColors.neutral900,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'POINTS',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.neutral400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .scale(begin: const Offset(0.8, 0.8)),
                const SizedBox(height: 32),
                // Game Breakdown header
                Row(
                  children: [
                    const Icon(
                      Symbols.grid_view,
                      color: AppColors.accent600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Game Breakdown',
                      style: AppTypography.h4.copyWith(
                        fontSize: 18,
                        color: AppColors.neutral900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Rounds list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: game.rounds.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final round = game.rounds[index];
                    return _buildRoundCard(context, round, index)
                        .animate()
                        .fadeIn(delay: (400 + index * 200).ms)
                        .slideY(begin: 0.1, end: 0);
                  },
                ),
                const SizedBox(height: 100), // Space for fixed button
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: PlayAgainSection(),
        ),
      ],
    );
  }

  Widget _buildRoundCard(BuildContext context, RoundModel round, int index) {
    final score = round.score ?? 0;
    final userEstimate = round.userEstimate ?? 1.0;
    final correctRatio = round.correctRatio;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ROUND ${index + 1}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.neutral400,
                    letterSpacing: 2,
                  ),
                ),
                switch (score) {
                  >= 80 => InfoChip.success(label: '$score pts'),
                  >= 50 => InfoChip.warning(label: '$score pts'),
                  _ => InfoChip.error(label: '$score pts'),
                },
              ],
            ),
          ),
          // Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: _buildItemBox(round.itemA, true, context)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildItemBox(round.itemB, false, context)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Ratios
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.neutral50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.neutral100),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'YOUR GUESS',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.neutral400,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEstimate >= 1
                            ? '${userEstimate.toStringAsFixed(_decimals(userEstimate))} : 1'
                            : '1 : ${(1 / userEstimate).toStringAsFixed(_decimals(1 / userEstimate))}',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.neutral900,
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
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        correctRatio >= 1
                            ? '${correctRatio.toStringAsFixed(_decimals(correctRatio))} : 1'
                            : '1 : ${(1 / correctRatio).toStringAsFixed(_decimals(1 / correctRatio))}',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.primary600,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildItemBox(ItemModel item, bool isFirst, BuildContext context) {
    final bgColor = isFirst ? AppColors.primary100 : AppColors.accent100;
    final borderColor = isFirst ? AppColors.primary200 : AppColors.accent200;
    final iconColor = isFirst ? AppColors.primary600 : AppColors.accent600;
    final titleColor = isFirst ? AppColors.primary900 : AppColors.accent900;
    final subTitleColor = isFirst ? AppColors.primary700 : AppColors.accent700;

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => ItemDetailsDialog(item: item),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: AppTypography.labelLarge.copyWith(color: titleColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: AppTypography.bodySmall.copyWith(color: subTitleColor),
            ),
            const SizedBox(height: 4),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: const Offset(4, 4),
                child: Icon(Symbols.info, size: 20, color: iconColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fixed bottom action button
class PlayAgainSection extends ConsumerWidget {
  const PlayAgainSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.neutral100.withOpacity(0),
            AppColors.neutral100.withOpacity(0.95),
            AppColors.neutral100,
          ],
        ),
      ),
      child: ActionButton.primary(
        onPressed: () {
          final cid = ref.read(currentCollectionProvider).value?.id;
          final mode = ref.read(gameModeProvider);
          if (cid != null) {
            GameRoute(
              cid: cid,
              gid: GameRepository.newGameId,
              mode: mode,
            ).go(context);
            ref.invalidate(gameControllerProvider);
          }
        },
        label: 'Play Again',
        icon: Symbols.replay,
        fullWidth: true,
      ),
    );
  }
}
