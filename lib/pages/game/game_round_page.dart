import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/collection/collection_item.dart';
import '../../models/game/game_round.dart';
import '../../models/game/game_session.dart';
import '../../providers/game/game_providers.dart';
import '../../services/navigation/routes.dart';

class GameRoundPage extends ConsumerStatefulWidget {
  const GameRoundPage({super.key});

  @override
  ConsumerState<GameRoundPage> createState() => _GameRoundPageState();
}

class _GameRoundPageState extends ConsumerState<GameRoundPage> {
  final TextEditingController _estimateController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    // Start the timer when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  void dispose() {
    _estimateController.dispose();
    super.dispose();
  }

  void _startTimer() {
    final session = ref.read(gameSessionNotifierProvider);
    if (session != null) {
      ref.read(gameTimerNotifierProvider.notifier).startTimer(session.mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(gameSessionNotifierProvider);
    final timerSeconds = ref.watch(gameTimerNotifierProvider);

    // If no active session, navigate back to mode selection
    if (session == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No active game session'),
              ElevatedButton(
                onPressed: () => const GameModeSelectionRoute().go(context),
                child: const Text('Start New Game'),
              ),
            ],
          ),
        ),
      );
    }

    final currentRound =
        ref.read(gameSessionNotifierProvider.notifier).getCurrentRound();
    if (currentRound == null) {
      // Navigate to results page if all rounds are completed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        const GameResultsRoute().go(context);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final itemA = currentRound.itemPair.itemA;
    final itemB = currentRound.itemPair.itemB;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Round ${currentRound.roundNumber} of ${session.rounds.length}'),
        actions: [
          if (session.mode == GameMode.research)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _openResearchBrowser,
              tooltip: 'Research Items',
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timer display
              _buildTimerDisplay(timerSeconds, session.mode),

              const SizedBox(height: 24),

              // Items comparison section
              _buildItemsComparisonCard(itemA, itemB),

              const SizedBox(height: 32),

              // Estimate input section
              if (!_isSubmitted) ...[
                _buildEstimateInputSection(),
              ] else ...[
                _buildResultSection(currentRound),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerDisplay(int seconds, GameMode mode) {
    final duration = Duration(seconds: seconds);
    final timerText =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final totalSeconds = mode == GameMode.simple ? 30 : 180;
    final progress = seconds / totalSeconds;

    // Use different colors based on remaining time
    Color timerColor = Colors.green;
    if (progress < 0.5) timerColor = Colors.orange;
    if (progress < 0.25) timerColor = Colors.red;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Time Remaining',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              timerText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: timerColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: timerColor,
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsComparisonCard(CollectionItem itemA, CollectionItem itemB) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compare These Items',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildItemCard(
                    title: itemA.title,
                    description: itemA.description,
                    label: 'A',
                    color: Colors.blue.shade100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildItemCard(
                    title: itemB.title,
                    description: itemB.description,
                    label: 'B',
                    color: Colors.green.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Question: How many times greater is the carbon footprint of Item A compared to Item B?',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard({
    required String title,
    required String description,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(label),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }

  Widget _buildEstimateInputSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your estimate:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _estimateController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g., 2.5',
                labelText: 'Estimate Ratio',
                helperText:
                    'Enter how many times greater Item A is compared to Item B',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitEstimate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit Estimate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection(GameRound round) {
    // Determine accuracy and color
    final accuracy = round.score ?? 0;
    Color accuracyColor = Colors.red;
    if (accuracy >= 70) accuracyColor = Colors.orange;
    if (accuracy >= 90) accuracyColor = Colors.green;

    return Card(
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
            ElevatedButton(
              onPressed: _nextRound,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Next Round'),
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
      ref.read(gameSessionNotifierProvider.notifier).submitEstimate(estimate);

      // Stop the timer
      ref.read(gameTimerNotifierProvider.notifier).cancelTimer();

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
    final session = ref.read(gameSessionNotifierProvider);
    if (session == null) {
      return;
    }

    if (session.isCompleted) {
      // Navigate to results page if game is completed
      const GameResultsRoute().go(context);
    } else {
      // Reset for next round
      setState(() {
        _isSubmitted = false;
        _estimateController.clear();
      });

      // Start timer for next round
      _startTimer();
    }
  }

  Future<void> _openResearchBrowser() async {
    // This is a placeholder - in a real app, you might open a specific research page
    // or a search page related to the current items
    const url = 'https://www.google.com';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open browser')),
        );
      }
    }
  }
}
