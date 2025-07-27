import 'package:flutter/material.dart';
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
          // Trophy image or icon
          const Icon(
            Icons.emoji_events,
            size: 80,
            color: Colors.amber,
          ),

          const SizedBox(height: 24),

          // Game mode info
          Text(
            '${GameMode.simple == GameMode.simple ? 'Simple' : 'Research'} Mode',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Total score
          Text(
            'Final Score',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            '${totalScore.toStringAsFixed(0)} / ${maxPossibleScore.toInt()}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(scorePercentage),
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

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
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: game.rounds.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) =>
                _buildRoundRow(context, game.rounds[index]),
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

                // Items side by side
                Row(
                  spacing: 2,
                  children: [
                    Expanded(
                      child: _buildItemButton(
                        context,
                        round.itemA,
                        isItemA: true,
                      ),
                    ),
                    Expanded(
                      child: _buildItemButton(
                        context,
                        round.itemB,
                        isItemA: false,
                      ),
                    ),
                  ],
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

  Widget _buildItemButton(
    BuildContext context,
    ItemModel item, {
    required bool isItemA,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isItemA
        ? colorScheme.secondaryContainer
        : colorScheme.tertiaryContainer;
    final foregroundColor = isItemA
        ? colorScheme.onSecondaryContainer
        : colorScheme.onTertiaryContainer;

    return OutlinedButton(
      onPressed: () => _showItemDetailsDialog(context, item),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
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
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            Icons.info_outline,
            size: 16,
            color: isItemA ? colorScheme.secondary : colorScheme.tertiary,
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

  Color _getScoreColor(int score) {
    return switch (score) {
      >= 90 => Colors.green,
      >= 70 => Colors.orange,
      _ => Colors.red,
    };
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

class ItemDetailsDialog extends ConsumerStatefulWidget {
  const ItemDetailsDialog({
    required this.item,
    super.key,
  });

  final ItemModel item;

  @override
  ConsumerState<ItemDetailsDialog> createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends ConsumerState<ItemDetailsDialog> {
  bool _isLoading = true;
  List<String> _sources = [];

  @override
  void initState() {
    super.initState();
    _loadSources();
  }

  Future<void> _loadSources() async {
    // In a real implementation, you would fetch the sources from a service
    // This is just a placeholder
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate loading sources
      // In a real app, you would use something like:
      // final sources = await ref.read(collectionServiceProvider).getSources(widget.item.sources);
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock sources for now
      final sources = widget.item.sources.map((id) => 'Source #$id').toList();

      setState(() {
        _sources = sources;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _sources = ['Error loading sources'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    splashRadius: 24,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Quantity
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.item.quantity,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Value
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.bar_chart,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Carbon Footprint Value'),
                subtitle: Text(
                  '${widget.item.value} kg CO₂e',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Category
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.category,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Category'),
                subtitle: Text(widget.item.category),
              ),

              const SizedBox(height: 8),

              // Description
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.description,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Description'),
                subtitle: Text(widget.item.description),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // Sources
              Text(
                'Sources',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              // Sources list
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                _sources.isEmpty
                    ? const Text('No sources available')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _sources.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.link, size: 14),
                                const SizedBox(width: 8),
                                Expanded(child: Text(_sources[index])),
                              ],
                            ),
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
