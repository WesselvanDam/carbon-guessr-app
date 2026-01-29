import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../data/models/collection.model.dart';
import '../../../../../data/models/item.model.dart';
import '../../../../../data/models/source.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
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
        // Sources
        const Text('Sources', style: AppTypography.labelLarge),

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
                AsyncLoading() => const Text(
                  'Placeholder source (2025)',
                  style: AppTypography.bodyLarge,
                ),
                AsyncError() => const Text(
                  'Failed to load sources.',
                  style: AppTypography.bodyLarge,
                ),
                AsyncData(:final value) =>
                  index >= value.length
                      ? const Text(
                          'Source not available',
                          style: AppTypography.bodyLarge,
                        )
                      : GestureDetector(
                          onTap: () => launchUrlString(
                            value[index].url,
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(
                            value[index].title,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.neutral900,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.neutral900,
                            ),
                          ),
                        ),
              };
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(
                      Symbols.link,
                      size: 20,
                      color: AppColors.accent600,
                    ),
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
