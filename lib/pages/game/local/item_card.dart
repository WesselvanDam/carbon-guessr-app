import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/collection/item.model.dart';
import '../game_controller.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({super.key, this.isFirst = false});

  const ItemCard.first({super.key}) : isFirst = true;

  const ItemCard.second({super.key}) : isFirst = false;

  final bool isFirst;

  void showDetails(ItemModel item, BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleLarge,
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(gameControllerProvider.select(
      (game) => isFirst
          ? game.valueOrNull?.currentRound.itemA
          : game.valueOrNull?.currentRound.itemB,
    ));

    final colorScheme = Theme.of(context).colorScheme;
    final Color mainColor =
        isFirst ? colorScheme.secondary : colorScheme.tertiary;
    final Color mainContainer = isFirst
        ? colorScheme.secondaryContainer
        : colorScheme.tertiaryContainer;
    final Color onMainContainer = isFirst
        ? colorScheme.onSecondaryContainer
        : colorScheme.onTertiaryContainer;

    return Material(
      color: mainContainer,
      borderRadius: BorderRadius.circular(16.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item == null ? null : () => showDetails(item, context),        
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item == null ? ' ' : '${item.category} · ${item.quantity}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: onMainContainer.withAlpha(180),
                      fontWeight: FontWeight.w600,
                    ),
              ).animate(target: item == null ? 0 : 1).fadeIn(),
              const SizedBox(height: 8.0),
              Text(
                item?.title ?? ' ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: onMainContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ).animate(target: item == null ? 0 : 1).fadeIn(),
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.info_outline, size: 18.0, color: mainColor),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.standard,
                      ),
                      onPressed:
                          item == null ? null : () => showDetails(item, context),
                    ).animate(target: item == null ? 0 : 1).fadeIn()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
