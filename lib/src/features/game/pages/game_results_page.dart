import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../data/models/item.model.dart';
import '../../../shared/design_system/app_colors.dart';
import '../../../shared/design_system/app_shadows.dart';
import '../../../shared/design_system/app_typography.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
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

    return SingleChildScrollView(
      child: Column(
        children: [
          // Score circle
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x262563EB), // rgba(37, 99, 235, 0.15)
                  offset: Offset(0, 10),
                  blurRadius: 40,
                  spreadRadius: -10,
                ),
              ],
              border: Border.all(color: AppColors.slate100),
            ),
            child: Column(
              children: [
                Text(
                  'FINAL SCORE',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 192,
                  height: 192,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle
                      SizedBox(
                        width: 192,
                        height: 192,
                        child: CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 16,
                          color: AppColors.slate100,
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
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return CircularProgressIndicator(
                              value: 1 - value,
                              strokeWidth: 16,
                              strokeCap: StrokeCap.round,
                              color: AppColors.primary,
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
                            '${totalScore.round()}',
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 60,
                              fontWeight: FontWeight.w900,
                              color: AppColors.text,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'POINTS',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.slate400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 8),
          // Game Breakdown header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Symbols.grid_view,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Game Breakdown',
                  style: AppTypography.h4.copyWith(
                    fontSize: 18,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Rounds list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: game.rounds.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final round = game.rounds[index];
              return _buildRoundCard(context, round, index)
                  .animate()
                  .fadeIn(
                    delay: (400 + index * 200).ms,
                  )
                  .slideY(begin: 0.1, end: 0);
            },
          ),
          const SizedBox(height: 100), // Space for fixed button
        ],
      ),
    );
  }

  Widget _buildRoundCard(BuildContext context, RoundModel round, int index) {
    final score = round.score?.round() ?? 0;
    final userEstimate = round.userEstimate ?? 1.0;
    final correctRatio = round.correctRatio;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.slate200),
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
                    color: AppColors.slate400,
                    letterSpacing: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: score >= 80
                        ? const Color(0xFFDCFCE7) // green-100
                        : score >= 60
                            ? const Color(0xFFFEF3C7) // yellow-100
                            : const Color(0xFFFEE2E2), // red-100
                    border: Border.all(
                      color: score >= 80
                          ? const Color(0xFF86EFAC) // green-200
                          : score >= 60
                              ? const Color(0xFFFDE047) // yellow-200
                              : const Color(0xFFFECACA), // red-200
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.add,
                        size: 12,
                        color: score >= 80
                            ? const Color(0xFF15803D) // green-700
                            : score >= 60
                                ? const Color(0xFFCA8A04) // yellow-700
                                : const Color(0xFFB91C1C), // red-700
                      ),
                      Text(
                        '$score pts',
                        style: AppTypography.labelSmall.copyWith(
                          color: score >= 80
                              ? const Color(0xFF15803D)
                              : score >= 60
                                  ? const Color(0xFFCA8A04)
                                  : const Color(0xFFB91C1C),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildItemBox(round.itemA, true),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildItemBox(round.itemB, false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Ratios
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate100),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'YOUR GUESS',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.slate400,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEstimate >= 1
                            ? '${userEstimate.toStringAsFixed(_decimals(userEstimate))} : 1'
                            : '1 : ${(1 / userEstimate).toStringAsFixed(_decimals(1 / userEstimate))}',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: AppColors.slate200,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'TRUE RATIO',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.slate400,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        correctRatio >= 1
                            ? '${correctRatio.toStringAsFixed(_decimals(correctRatio))} : 1'
                            : '1 : ${(1 / correctRatio).toStringAsFixed(_decimals(1 / correctRatio))}',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.primary,
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

  Widget _buildItemBox(ItemModel item, bool isFirst) {
    final bgColor = isFirst ? AppColors.blue50 : AppColors.orange50;
    final borderColor = isFirst ? AppColors.blue100 : AppColors.orange100;
    final iconColor = isFirst ? AppColors.primary : AppColors.secondary;

    // Map item category to icon
    IconData icon = Symbols.inventory_2; // default
    if (item.category.toLowerCase().contains('food') ||
        item.category.toLowerCase().contains('dairy')) {
      icon = Symbols.nutrition;
    } else if (item.category.toLowerCase().contains('transport')) {
      icon = Symbols.directions_car;
    } else if (item.category.toLowerCase().contains('phone') ||
        item.category.toLowerCase().contains('electronic')) {
      icon = Symbols.smartphone;
    } else if (item.category.toLowerCase().contains('vegetable')) {
      icon = Symbols.compost;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            item.quantity,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textLight,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// Fixed bottom action button
class GameResultsActions extends ConsumerWidget {
  const GameResultsActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bg.withOpacity(0),
            AppColors.bg.withOpacity(0.95),
            AppColors.bg,
          ],
        ),
      ),
      child: PrimaryButton(
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
