import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../data/models/item.model.dart';
import '../../../../design_system/components/buttons/icon_buttons.dart';
import '../../../../design_system/components/chips/info_chip.dart';
import '../../../../design_system/components/dialogs/dialog.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../collection/providers/current_collection.dart';
import 'source_list.dart';

class ItemDetailsDialog extends ConsumerWidget {
  const ItemDetailsDialog({
    required this.item,
    this.showExtra = true,
    super.key,
  });

  final ItemModel item;
  final bool showExtra;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _itemInfo(context),
            if (showExtra) _sourcesAndValue(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _itemInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(child: Text(item.title, style: AppTypography.h4)),
              RoundedIconButton(
                size: 32,
                icon: Symbols.close,
                iconColor: AppColors.neutral400,
                backgroundColor: AppColors.neutral50,
                borderColor: AppColors.neutral200,
                onPressed: () => context.pop(),
              ),
            ],
          ),

          if (item.quantity.isNotEmpty || item.category.isNotEmpty)
            Row(
              spacing: 8,
              children: [
                if (item.category.isNotEmpty)
                  InfoChip.primary(label: item.category),
                if (item.quantity.isNotEmpty)
                  InfoChip.accent(label: item.quantity),
              ],
            ),

          if (item.description.isNotEmpty)
            MarkdownBody(
              data: item.description,
              styleSheet: MarkdownStyleSheet(
                p: AppTypography.bodyLarge.copyWith(
                  color: AppColors.neutral600,
                  height: 1.6,
                ),
                a: AppTypography.bodyLarge.copyWith(
                  color: AppColors.primary600,
                  height: 1.6,
                  decoration: TextDecoration.underline,
                  decorationThickness: 4,
                  decorationColor: AppColors.primary400,
                ),
              ),
              onTapLink: (text, url, title) => url == null
                  ? null
                  : launchUrlString(url, mode: LaunchMode.externalApplication),
            ),
        ],
      ),
    );
  }

  Widget _sourcesAndValue(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.neutral50,
        border: Border(top: BorderSide(color: AppColors.neutral200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${collection.value?.quantity.capitalize} value',
            style: AppTypography.labelLarge,
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 8,
            children: [
              const Icon(Symbols.bar_chart, color: AppColors.primary600),
              Text(
                '${item.value.toSignificantFigures(3)} ${collection.value?.unit}',
                style: AppTypography.h4,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Sources
          if (item.sources.isEmpty)
            // TODO: Integrate this in the SourceList widget
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.source,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('Sources'),
              subtitle: const Text('No sources available.'),
            ),

          if (item.sources.isNotEmpty && collection.value != null)
            SourceList(collection: collection.value!, item: item),
        ],
      ),
    );
  }
}
