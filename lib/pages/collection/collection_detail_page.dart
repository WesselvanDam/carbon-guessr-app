import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection/collection_providers.dart';
import '../../utils/string_extensions.dart';
import '../../widgets/collection/collection_switcher.dart';

/// A page that displays detailed information about a collection item
class CollectionDetailPage extends ConsumerWidget {
  const CollectionDetailPage({
    required this.id,
    super.key,
  });
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the current collection to keep track of which collection we're viewing
    final currentCollection = ref.watch(currentCollectionNotifierProvider);

    final itemAsync = ref.watch(localizedCollectionItemProvider(id, 'en-US'));
    final infoAsync = ref.watch(collectionInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('${currentCollection.capitalize()} Item'),
        actions: const [
          // Add collection switcher
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CollectionSwitcher(
              showLabel: false,
            ),
          ),
        ],
      ),
      body: itemAsync.when(
        data: (item) => _buildDetailView(
          context,
          ref,
          item,
          infoAsync.valueOrNull,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading data: $error'),
        ),
      ),
    );
  }

  Widget _buildDetailView(
    BuildContext context,
    WidgetRef ref,
    CollectionItem item,
    CollectionInfo? info,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item title
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),

          // Category and value
          Row(
            children: [
              Chip(
                label: Text(item.category),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                '${item.value} ${info?.unit ?? ''}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(item.description),
          const SizedBox(height: 24),

          // Sources section
          Text(
            'Sources',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _buildSourcesList(context, ref, item),
        ],
      ),
    );
  }

  Widget _buildSourcesList(
    BuildContext context,
    WidgetRef ref,
    CollectionItem item,
  ) {
    final sourcesAsync = ref.watch(collectionItemSourcesProvider(item.id));

    return sourcesAsync.when(
      data: (sources) {
        if (sources.isEmpty) {
          return const Text('No sources available');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sources.length,
          itemBuilder: (context, index) {
            final source = sources[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(source.mla),
                    if (source.url.isNotEmpty) const SizedBox(height: 4),
                    if (source.url.isNotEmpty)
                      InkWell(
                        child: Text(
                          source.url,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          // Open URL
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error loading sources: $error'),
    );
  }
}
