import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/collection/collection_info.dart';
import '../../../router/routes.dart';

class CollectionCard extends ConsumerWidget {
  const CollectionCard({required this.collectionInfo, super.key});

  final CollectionInfo collectionInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${collectionInfo.size} items',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
            semanticsLabel: 'Number of items: ${collectionInfo.size}',
          ),
          const SizedBox(height: 8.0),
          Text(
            collectionInfo.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
            semanticsLabel: 'Collection name: ${collectionInfo.title}',
          ),
          const SizedBox(height: 8.0),
          Text(
            collectionInfo.description,
            style: Theme.of(context).textTheme.bodyMedium,
            semanticsLabel: 'Description: ${collectionInfo.description}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Unit: ${collectionInfo.unit}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                semanticsLabel: 'Unit: ${collectionInfo.unit}',
              ),
              TextButton.icon(
                icon: const Icon(Icons.arrow_forward, size: 18.0),
                label: const Text('View Collection'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: const TextStyle(fontSize: 14.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () =>
                    CollectionRoute(cid: collectionInfo.id).go(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
