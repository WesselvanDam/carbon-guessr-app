import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../data/models/item.model.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../shared/utils/extensions.dart';
import '../../collection/providers/current_collection.dart';
import 'item_details_dialog.dart';

enum ItemTileVariant { oneLine, twoLines, threeLines }

class ItemTile extends ConsumerWidget {
  const ItemTile({
    required this.item,
    required this.variant,
    required this.isFirst,
    super.key,
  });

  final ItemModel? item;
  final ItemTileVariant variant;
  final bool isFirst;

  bool get _showExtra => variant == ItemTileVariant.threeLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = isFirst ? AppColors.primary600 : AppColors.accent600;
    final indicatorColor = isFirst ? AppColors.primary500 : AppColors.accent500;
    final unit = ref.watch(currentCollectionProvider).requireValue.unit;

    return InkWell(
      onTap: item != null
          ? () => showDialog(
              context: context,
              builder: (context) =>
                  ItemDetailsDialog(item: item!, showExtra: _showExtra),
            )
          : null,
      child: ColoredBox(
        color: AppColors.neutral50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              // Indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title (always shown)
                    Text(
                      item?.title ?? '',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.neutral900,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Subtitle (shown in two or three line variants)
                    if (variant != ItemTileVariant.oneLine) ...[
                      const SizedBox(height: 2),
                      if ((item?.subtitle ?? '').isNotEmpty)
                        Text(
                          item!.subtitle,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.neutral600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                    // Value (shown only in three line variant)
                    if (variant == ItemTileVariant.threeLines) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${item?.value.toSignificantFigures(3).toString() ?? ''} $unit',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.neutral500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Info icon
              Icon(Symbols.info, size: 20, color: iconColor, weight: 600),
            ],
          ),
        ),
      ),
    );
  }
}
