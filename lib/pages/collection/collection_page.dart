import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/game/game.model.dart';
import '../../router/routes.dart';
import '../../services/collection/collection_providers.dart';
import '../../services/game/game_repository.dart';
import '../../utils/extensions.dart';
import 'challenge_dialog.dart';

class CollectionPage extends ConsumerWidget {
  const CollectionPage({required this.cid, super.key});

  final String cid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionProvider(cid));

    return collection.when(
      data: (info) {
        void startGameCallback(GameMode mode, [String? gameId]) => GameRoute(
              cid: info.id,
              gid: gameId ?? GameRepository.newGameId,
              mode: mode,
            ).go(context);

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leadingWidth: 68,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton.outlined(
                padding: const EdgeInsets.all(12.0),
                iconSize: 28,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: BorderSide(
                      color:
                          Theme.of(context).colorScheme.onSurface.withAlpha(50),
                      width: 2),
                ),
              ),
            ),
            title: Column(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(info.title.toTitleCase()),
                Text(
                  '${info.quantity.toSentenceCase()} · ${info.unit}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.tagline,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  MarkdownBody(
                    data: info.description,
                    styleSheet: MarkdownStyleSheet(
                      p: Theme.of(context).textTheme.bodyLarge,
                      a: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    onTapLink: (text, url, title) => url == null
                        ? null
                        : launchUrlString(
                            url,
                            mode: LaunchMode.externalApplication,
                          ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Choose a Game Mode',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    context,
                    () => startGameCallback(GameMode.simple),
                    'Simple',
                    'Match pairs of items within 30 seconds. Trust your intuition.',
                    Icons.speed,
                    Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    context,
                    () => _showChallengeDialog(context, (gameId) => startGameCallback(GameMode.challenge, gameId)),
                    'Challenge Friends',
                    'Share a PIN with friends to compare scores on the same items.',
                    Icons.people,
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

  void _showChallengeDialog(
    BuildContext context,
    Function(String) startGameCallback,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          ChallengeDialog(startGameCallback: startGameCallback),
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
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 32, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
