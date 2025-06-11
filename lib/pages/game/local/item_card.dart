import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/collection/collection_item.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({required this.item, super.key, this.isFirst = false});

  const ItemCard.first({required this.item, super.key}) : isFirst = true;

  const ItemCard.second({required this.item, super.key}) : isFirst = false;

  final CollectionItem item;
  final bool isFirst;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color mainColor = isFirst ? colorScheme.secondary : colorScheme.tertiary;
    final Color mainContainer = isFirst ? colorScheme.secondaryContainer : colorScheme.tertiaryContainer;
    final Color onMainContainer = isFirst ? colorScheme.onSecondaryContainer : colorScheme.onTertiaryContainer;

    return Container(
      decoration: BoxDecoration(
        color: mainContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.category} · ${item.quantity}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: onMainContainer.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: onMainContainer,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: Icon(Icons.info_outline, size: 18.0, color: mainColor),
                label: Text(
                  'Details',
                  style: TextStyle(color: mainColor),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: mainColor,
                  textStyle: const TextStyle(fontSize: 14.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.standard,
                ),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: mainColor,
                            ),
                      ),
                      content: Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
