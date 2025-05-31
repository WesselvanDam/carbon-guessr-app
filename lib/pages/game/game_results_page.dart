import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_round.dart';
import '../../models/game/game_session.dart';
import '../../router/routes.dart';

class GameResultsPage extends ConsumerWidget {
  const GameResultsPage({required this.session, super.key});

  final GameSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalScore = session.totalScore;
    final maxPossibleScore = session.rounds.length * 100.0;
    final scorePercentage = (totalScore / maxPossibleScore) * 100;

    // Get a feedback message based on the score
    final feedbackMessage = _getFeedbackMessage(scorePercentage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Results'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    feedbackMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Round details
              _buildRoundDetailsCard(context, session),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => const HomeRoute().go(context),
                      icon: const Icon(Icons.home),
                      label: const Text('Home'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundDetailsCard(BuildContext context, GameSession session) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Round Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            ...session.rounds.map((round) => _buildRoundRow(context, round)),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundRow(BuildContext context, GameRound round) {
    // Skip incomplete rounds
    if (!round.isCompleted || round.score == null) {
      return const SizedBox.shrink();
    }

    // Determine accuracy color
    final accuracy = round.score!;
    Color accuracyColor = Colors.red;
    accuracyColor = _getScoreColor(accuracy);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                'Round ${round.roundNumber}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '${round.score!.toStringAsFixed(0)} points',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accuracyColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            children: [
              const Text('Your estimate:'),
              const Spacer(),
              Text(round.userEstimate?.toStringAsFixed(2) ?? 'N/A'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Row(
            children: [
              const Text('Correct ratio:'),
              const Spacer(),
              Text(round.correctRatio.toStringAsFixed(2)),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Color _getScoreColor(double percentage) {
    return switch (percentage) {
      >= 90 => Colors.green,
      >= 70 => Colors.orange,
      _ => Colors.red,
    };
  }

  String _getFeedbackMessage(double percentage) {
    if (percentage >= 90) {
      return 'Excellent! You have a great understanding of carbon footprints!';
    } else if (percentage >= 70) {
      return 'Good job! You have a solid understanding of carbon footprints.';
    } else if (percentage >= 50) {
      return 'Not bad! You have some understanding of carbon footprints.';
    } else {
      return 'Keep learning! Carbon footprints can be tricky to estimate.';
    }
  }
}
