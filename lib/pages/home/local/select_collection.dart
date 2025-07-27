import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/collection/collection_providers.dart';
import 'collection_card.dart';

class CollectionSelector extends ConsumerWidget {
  const CollectionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);

    return collections.when(
      data: (data) {
        final collections = data.values.toList();
        return ListView.separated(
          shrinkWrap: true,
          itemCount: collections.length + 1,
          itemBuilder: (context, index) {
            if (index == collections.length) {
              return Card.outlined(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: const SizedBox(
                  height: 180,
                  child: Center(child: Text('More coming soon!')),
                ),
              );
            }
            return CollectionCard(collection: collections[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
