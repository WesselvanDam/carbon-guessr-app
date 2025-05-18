import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/collection/collection_providers.dart';
import '../../utils/string_extensions.dart';

/// A drawer widget that displays all available collections
class CollectionDrawer extends ConsumerWidget {
  /// Creates a collection drawer
  const CollectionDrawer({
    this.availableCollections = const ['carbon', 'energy', 'water', 'waste'],
    this.onCollectionSelected,
    super.key,
  });

  /// The list of available collections
  final List<String> availableCollections;

  /// Callback when a collection is selected
  final Function(String)? onCollectionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCollection = ref.watch(currentCollectionNotifierProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Collections',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select a collection to explore its data',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          ...availableCollections.map((collection) {
            final isSelected = collection == currentCollection;
            return ListTile(
              title: Text(collection.capitalize()),
              selected: isSelected,
              leading: Icon(
                isSelected ? Icons.folder_open : Icons.folder,
                color: isSelected ? theme.colorScheme.primary : null,
              ),
              onTap: () {
                // Update the current collection
                ref
                    .read(currentCollectionNotifierProvider.notifier)
                    .setCollection(collection);

                // Call the callback if provided
                onCollectionSelected?.call(collection);

                // Close the drawer
                Navigator.pop(context);
              },
            );
          }),
          const Divider(),
          ListTile(
            title: const Text('About Collections'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  /// Shows an about dialog with information about collections
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Collections'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Collections are datasets containing related information.'),
              SizedBox(height: 16),
              Text(
                  'Each collection has its own set of items, sources, and localized content.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
