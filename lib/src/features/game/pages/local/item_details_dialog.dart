import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../data/models/item.model.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../collection/providers/current_collection.dart';
import 'source_list.dart';

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
