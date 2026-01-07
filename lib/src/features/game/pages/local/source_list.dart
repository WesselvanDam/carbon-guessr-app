import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../data/models/collection.model.dart';
import '../../../../../data/models/item.model.dart';
import '../../../../../data/models/source.dart';
import '../../../collection/providers/current_collection.dart';
import '../../providers/sources.dart';

final itemSourcesProvider = FutureProvider.family
    .autoDispose<List<Source>, ItemModel>((ref, item) async {
      final collection = await ref.watch(
        currentCollectionProvider.selectAsync((collection) => collection),
      );
      return ref
          .read(sourcesProvider(collection.id).notifier)
          .getSourcesByIds(item.sources);
    });

class SourceList extends ConsumerWidget {
  const SourceList({required this.collection, required this.item, super.key});

  final CollectionModel collection;
  final ItemModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sources = ref.watch(itemSourcesProvider(item));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const Divider(height: 32),

        // Sources
        Text('Sources', style: Theme.of(context).textTheme.titleMedium),

        Skeletonizer(
          enabled: sources.isLoading,
          effect: ShimmerEffect(
            baseColor: Theme.of(context).colorScheme.surfaceDim,
            highlightColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item.sources.length,
            itemBuilder: (context, index) {
              final child = switch (sources) {
                AsyncLoading() => const Text('Placeholder source (2025)'),
                AsyncError() => const Text('Failed to load sources.'),
                AsyncData(:final value) =>
                  index >= value.length
                      ? const Text('Source not available')
                      : GestureDetector(
                          onTap: () => launchUrlString(
                            value[index].url,
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(
                            value[index].title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
              };
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.link, size: 14),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(width: double.infinity, child: child),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
