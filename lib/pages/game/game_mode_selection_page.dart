import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_session.dart';
import '../../providers/collection/collection_providers.dart';
import '../../providers/game/game_providers.dart';
import '../../services/navigation/routes.dart';

class GameModeSelectionPage extends ConsumerWidget {
  const GameModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionInfo = ref.watch(collectionInfoProvider);

    // Check if collection info is available
    if (!collectionInfo.hasValue) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Select Game Mode'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Game Mode'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose a Game Mode',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildGameModeCard(
                context,
                ref,
                GameMode.simple,
                'Simple Mode',
                'Match pairs of items within 30 seconds.\nFocus on your first impressions.',
                Icons.speed,
                Colors.blue,
              ),
              const SizedBox(height: 24),
              _buildGameModeCard(
                context,
                ref,
                GameMode.research,
                'Research Mode',
                'Take up to 3 minutes to research and compare items.\nOpen browser for more information.',
                Icons.search,
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeCard(
    BuildContext context,
    WidgetRef ref,
    GameMode mode,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _startGame(context, ref, mode),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startGame(
      BuildContext context, WidgetRef ref, GameMode mode) async {
    try {
      final collectionInfo = ref.read(collectionInfoProvider).asData!.value;
      debugPrint('info: $collectionInfo');

      // Create a new game session with selected mode

      await ref
          .read(gameSessionNotifierProvider.notifier)
          .createNewSession(mode, collectionInfo);

      // Navigate to the game round page
      if (context.mounted) {
        const GameRoundRoute().go(context);
      }
    } catch (e) {
      // Show error dialog
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to start game: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
