import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/collection/item.model.dart';
import '../../models/game/game.model.dart';
import '../../models/game/round.model.dart';
import '../../router/routes.dart';
import '../../services/collection/collection_providers.dart';
import '../../services/game/game_providers.dart';
import '../../services/game/game_repository.dart';
import '../../utils/extensions.dart';
import '../../widgets/score_pill.dart';
import 'game_controller.dart';
import 'local/final_score.dart';
import 'local/item_details_dialog.dart';

class GameResultsPage extends ConsumerWidget {
  const GameResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value!;

    final totalScore = game.totalScore;
    final maxPossibleScore = game.rounds.length * 100.0;
    final scorePercentage = ((totalScore / maxPossibleScore) * 100).round();

    // Get a feedback message based on the score
    final feedbackMessage = _getFeedbackMessage(scorePercentage);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CoolScoreWidget(score: totalScore),

          const SizedBox(height: 32),

          // Feedback message
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    feedbackMessage,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
            duration: 600.ms,
            delay: 300.ms,
          ),

          const SizedBox(height: 32),

          // Round details
          _buildRoundDetailsCard(context, game),

          const SizedBox(height: 32),

          // Action buttons
          OverflowBar(
            alignment: MainAxisAlignment.end,
            overflowAlignment: OverflowBarAlignment.center,
            overflowDirection: VerticalDirection.up,
            spacing: 16,
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Back to collection'),
              ),
              FilledButton.icon(
                onPressed: () {
                  GameRoute(
                    cid: ref.read(currentCollectionProvider).value!.id,
                    gid: GameRepository.newGameId,
                    mode: ref.read(gameModeProvider),
                  ).go(context);
                  ref.invalidate(gameControllerProvider);
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Again'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundDetailsCard(BuildContext context, GameModel game) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with stylized background
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Game Breakdown',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ).animate().fadeIn(
            duration: 600.ms,
            delay: 500.ms,
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: game.rounds.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) =>
                _buildRoundRow(context, game.rounds[index]).animate().fadeIn(
                  duration: 600.ms,
                  delay: 500.ms + (index * 300).ms,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildRoundRow(BuildContext context, RoundModel round) {
    final score = round.score;
    final valueStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        );
    final labelStyle = Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );

    return Container(
      decoration: BoxDecoration(
        color: round.roundNumber.isEven
            ? Theme.of(context).colorScheme.surfaceContainer
            : Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Round number label
                Text(
                  'ROUND ${round.roundNumber}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),

                const SizedBox(height: 12),

                IntrinsicHeight(
                  child: Row(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildItemButton(context, round.itemA)),
                      Expanded(child: _buildItemButton(context, round.itemB)),
                    ],
                  ),
                ),

                const SizedBox(height: 16), // Results section
                SizedBox(
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // User estimate
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                round.userEstimate?.ratioToReadableString() ??
                                    'N/A',
                                textAlign: TextAlign.center,
                                style: valueStyle,
                              ),
                            ),
                            Text(
                              'YOUR GUESS',
                              style: labelStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Correct ratio
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                round.correctRatio.ratioToReadableString(),
                                textAlign: TextAlign.center,
                                style: valueStyle,
                              ),
                            ),
                            Text(
                              'TRUE RATIO',
                              style: labelStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Points
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ScorePill(
                              score: score,
                              style: valueStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                            ),
                            Text(
                              'POINTS',
                              style: labelStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemButton(BuildContext context, ItemModel item) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color mainContainer =
        item.isItemA ? colorScheme.primary : colorScheme.tertiaryContainer;
    final Color onMainContainer =
        item.isItemA ? colorScheme.onPrimary : colorScheme.onTertiaryFixedVariant;

    return OutlinedButton(
      onPressed: () => _showItemDetailsDialog(context, item),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        backgroundColor: mainContainer,
        foregroundColor: onMainContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item.quantity,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: onMainContainer.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.info_outline,
            size: 16,
            color: onMainContainer,
          ),
        ],
      ),
    );
  }

  void _showItemDetailsDialog(BuildContext context, ItemModel item) {
    showDialog(
      context: context,
      builder: (context) => ItemDetailsDialog(item: item),
    );
  }

  String _getFeedbackMessage(int score) {
    if (score >= 90) {
      return 'Excellent! You have a great understanding of carbon footprints!';
    } else if (score >= 70) {
      return 'Good job! You have a solid understanding of carbon footprints.';
    } else if (score >= 50) {
      return 'Not bad! You have some understanding of carbon footprints.';
    } else {
      return 'Keep learning! Carbon footprints can be tricky to estimate.';
    }
  }
}
