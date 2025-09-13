import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/collection/item.model.dart';
import '../../../models/collection/source.dart';
import '../../../router/router.dart';
import '../../../services/collection/collection_providers.dart';
import '../../../utils/extensions.dart';

class ItemDetailsDialog extends ConsumerWidget {
  const ItemDetailsDialog({
    required this.item,
    this.showValue = true,
    this.showSources = true,
    super.key,
  });

  final ItemModel item;
  final bool showValue;
  final bool showSources;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    splashRadius: 24,
                  ),
                ],
              ),

              // Quantity
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item.quantity,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Force double spacing between quantity and the next section
              const SizedBox.shrink(),

              // Value
              if (showValue)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.bar_chart,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text('${collection.value?.quantity.capitalize} value'),
                  subtitle: Text(
                    '${item.value.toSignificantFigures(3)} ${collection.value?.unit}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

              // Category
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.category,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Category'),
                subtitle: Text(item.category),
              ),

              const SizedBox(height: 8),

              // Description
              MarkdownBody(
                data: item.description,
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

              // Sources
              if (showSources && item.sources.isEmpty)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.source,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: const Text('Sources'),
                  subtitle: const Text('No sources available.'),
                ),

              if (showSources && item.sources.isNotEmpty)
                Consumer(
                  builder: (context, ref, child) {
                    final cid = ref.watch(
                      routerProvider.select(
                        (router) => router.state.pathParameters['cid'],
                      ),
                    );
                    if (cid == null || cid.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final sources = ref.watch(
                      collectionItemSourcesProvider(cid, item.sources),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        const Divider(height: 32),

                        // Sources
                        Text(
                          'Sources',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: item.sources.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.link, size: 14),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Skeletonizer(
                                      enabled: sources.isLoading,
                                      effect: ShimmerEffect(
                                        baseColor: Theme.of(
                                          context,
                                        ).colorScheme.surfaceDim,
                                        highlightColor: Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHighest,
                                      ),
                                      switchAnimationConfig:
                                          const SwitchAnimationConfig(
                                            duration: Duration(
                                              milliseconds: 500,
                                            ),
                                          ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: switch (sources) {
                                          AsyncLoading() => const Text(
                                            'Placeholder source (2025)',
                                          ),
                                          AsyncError() => const Text(
                                            'Failed to load sources.',
                                          ),
                                          AsyncData<List<Source>>(
                                            :final value,
                                          ) =>
                                            GestureDetector(
                                              onTap: () => launchUrlString(
                                                value[index].url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              ),
                                              child: Text(
                                                value[index].title,
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
