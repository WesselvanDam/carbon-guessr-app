import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/collection/collection_providers.dart';
import '../../../router/routes.dart';
import 'collection_card.dart';

class CollectionSelector extends ConsumerWidget {
  const CollectionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsInfoProvider);

    return collections.when(
      data: (collections) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final collection = collections[index];
            return CollectionCard(collectionInfo: collection);
          },
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
