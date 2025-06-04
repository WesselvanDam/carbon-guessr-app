import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_session.dart';
import '../../providers/collection/collection_providers.dart';
import '../../router/routes.dart';
import '../../services/game/game_service.dart';

class CollectionPage extends ConsumerWidget {
  const CollectionPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionInfo = ref.watch(collectionInfoProvider(id));

    return collectionInfo.when(
      data: (info) {
        void startGameCallback(GameMode mode) => GameRoute(
              cid: info.id,
              gid: GameService.newGameId,
              mode: mode,
            ).go(context);

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
                    () => startGameCallback(GameMode.simple),
                    'Simple Mode',
                    'Match pairs of items within 30 seconds.\nFocus on your first impressions.',
                    Icons.speed,
                    Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 24),
                  _buildGameModeCard(
                    context,
                    () => startGameCallback(GameMode.research),
                    'Research Mode',
                    'Take up to 3 minutes to research and compare items.\nOpen browser for more information.',
                    Icons.search,
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Game Mode'),
          ),
          body: Center(
            child: Text('Error loading collection: $error'),
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Game Mode'),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildGameModeCard(
    BuildContext context,
    GestureTapCallback onTap,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
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
              const SizedBox(height: 8, width: double.infinity),
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
}
