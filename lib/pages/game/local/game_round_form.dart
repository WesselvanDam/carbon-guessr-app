import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/collection/collection_item.dart';
import '../../../models/game/game_round.dart';
import 'custom_ratio_field.dart';
import 'game_timer_provider.dart';

class GameRoundForm extends ConsumerStatefulWidget {
  const GameRoundForm({
    required this.round,
    required this.onSubmit,
    required this.onNextRound,
    super.key,
  });

  final GameRound round;
  final void Function(double) onSubmit;
  final VoidCallback onNextRound;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundState();
}

class _GameRoundState extends ConsumerState<GameRoundForm> {
  final TextEditingController _estimateController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _estimateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasTimeLeft =
        ref.watch(gameTimerProvider.select((state) => state > 0));
    final itemA = widget.round.itemPair.itemA;
    final itemB = widget.round.itemPair.itemB;

    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Items comparison section
        _buildItemsComparisonCard(itemA, itemB),
        if (!_isSubmitted && hasTimeLeft) ...[
          _buildEstimateInputSection(),
          _buildCustomRatioField(),
        ] else ...[
          _buildResultSection(widget.round),
        ],
      ],
    );
  }

  Widget _buildItemsComparisonCard(CollectionItem itemA, CollectionItem itemB) {
    return Row(
      spacing: 2,
      children: [
        Expanded(
          child: _buildItemCard(
            title: itemA.title,
            description: itemA.description,
            label: 'A',
            color: Colors.blue.shade700,
          ),
        ),
        Expanded(
          child: _buildItemCard(
            title: itemB.title,
            description: itemB.description,
            label: 'B',
            color: Colors.green.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard({
    required String title,
    required String description,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }

  Widget _buildEstimateInputSection() {
    return Card.filled(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  const TextSpan(text: 'You estimate that the ratio between '),
                  TextSpan(
                    text: widget.round.itemPair.itemA.title,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: widget.round.itemPair.itemB.title,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' is '),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _estimateController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      suffixText: ':1',
                      border: OutlineInputBorder(),
                      hintText: 'Enter ratio',
                    ),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _submitEstimate,
                  child: const Text('Submit'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'You can enter a value directly or use the visual ratio tool below.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomRatioField() {
    final itemA = widget.round.itemPair.itemA;
    final itemB = widget.round.itemPair.itemB;

    // Initialize with either the user's current estimate or a default value
    double initialRatio = 1.2;
    if (_estimateController.text.isNotEmpty) {
      final double? parsedValue = double.tryParse(_estimateController.text);
      if (parsedValue != null && parsedValue > 0) {
        initialRatio = parsedValue;
      }
    }

    return Card.filled(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Adjust Ratio Visually',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomRatioField(
              initialRatio: initialRatio,
              firstItemTitle: itemA.title,
              secondItemTitle: itemB.title,
              firstItemColor: Colors.blue.shade700,
              secondItemColor: Colors.green.shade700,
              onRatioChanged: (newRatio) {
                // Update the text field with the new ratio
                setState(() {
                  _estimateController.text = newRatio.toStringAsFixed(2);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection(GameRound round) {
    // Determine accuracy and color
    final accuracy = round.score ?? 0;
    final Color accuracyColor = switch (accuracy) {
      >= 90 => Colors.green,
      >= 70 => Colors.orange,
      _ => Colors.red,
    };

    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Round Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildResultRow('Your Estimate:',
                round.userEstimate?.toStringAsFixed(2) ?? 'N/A'),
            _buildResultRow(
                'Correct Ratio:', round.correctRatio.toStringAsFixed(2)),
            const Divider(),
            _buildResultRow(
              'Accuracy:',
              '${accuracy.toStringAsFixed(1)}%',
              valueColor: accuracyColor,
              valueFontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _nextRound,
                child: const Text('Next Round'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value,
      {Color? valueColor, FontWeight? valueFontWeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: valueFontWeight ?? FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  void _submitEstimate() {
    // Validate input
    if (_estimateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an estimate')),
      );
      return;
    }

    try {
      // Parse user estimate
      final estimate = double.parse(_estimateController.text);
      if (estimate <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a positive number')),
        );
        return;
      }

      // Submit the estimate
      debugPrint('Submitting estimate: $estimate');
      widget.onSubmit(estimate);

      // Stop the timer
      debugPrint('Stopping timer');
      // ref.read(gameTimerNotifierProvider.notifier).cancelTimer();

      // Update UI to show results
      setState(() {
        _isSubmitted = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  void _nextRound() {
    setState(() {
      _isSubmitted = false;
      _estimateController.clear();
    });
    ref.read(gameTimerProvider.notifier).cancelTimer();
    widget.onNextRound();
  }
}
