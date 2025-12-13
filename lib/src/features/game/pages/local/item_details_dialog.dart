import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../client/talker.dart';
import '../../../../../data/models/collection.model.dart';
import '../../../../../data/models/item.model.dart';
import '../../../../../data/models/source.dart';
import '../../../../../router/router.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../collection/providers/current_collection.dart';
import '../../providers/sources.dart';

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

              if (item.quantity.isNotEmpty)
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

              if (item.category.isNotEmpty)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.category,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: const Text('Category'),
                  subtitle: Text(item.category),
                ),

              if (item.description.isNotEmpty)
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

              if (showSources &&
                  item.sources.isNotEmpty &&
                  collection.value != null)
                SourceList(collection: collection.value!, item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class SourceList extends ConsumerStatefulWidget {
  const SourceList({required this.collection, required this.item, super.key});

  final CollectionModel collection;
  final ItemModel item;

  @override
  ConsumerState<SourceList> createState() => _SourceListState();
}

class _SourceListState extends ConsumerState<SourceList> {
  late final Future<List<Source>> _fetchSources;

  @override
  void initState() {
    super.initState();
    _fetchSources = ref
        .read(sourcesProvider(widget.collection.id).notifier)
        .getSourcesByIds(widget.item.sources);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: _fetchSources,
      builder: (context, sources) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            const Divider(height: 32),

            // Sources
            Text('Sources', style: Theme.of(context).textTheme.titleMedium),

            Skeletonizer(
              enabled: sources.connectionState == ConnectionState.waiting,
              effect: ShimmerEffect(
                baseColor: Theme.of(context).colorScheme.surfaceDim,
                highlightColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.item.sources.length,
                itemBuilder: (context, index) {
                  Widget child;
                  if (sources.connectionState == ConnectionState.waiting) {
                    child = const Text('Placeholder source (2025)');
                  } else if (sources.hasError) {
                    child = const Text('Failed to load sources.');
                  } else {
                    if (sources.data == null) {
                      talker.debug('Sources data is null');
                      return const SizedBox();
                    }
                    if (index >= sources.data!.length) {
                      talker.debug(
                        'Index $index out of bounds for sources data of length ${sources.data!.length}',
                      );

                      return const Text('Source not found');
                    }

                    final source = sources.data![index];
                    child = GestureDetector(
                      onTap: () => launchUrlString(
                        source.url,
                        mode: LaunchMode.externalApplication,
                      ),
                      child: Text(
                        source.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
                  }
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
      },
    );
  }
}
