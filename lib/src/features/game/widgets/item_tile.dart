import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../collection/providers/current_collection.dart';
import '../models/round.model.dart';
import 'item_details_dialog.dart';

class ItemTile extends ConsumerWidget {
  const ItemTile({
    required this.isFirst,
    required this.context,
    required this.round,
    super.key,
  });

  final bool isFirst;
  final BuildContext context;
  final RoundModel? round;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = isFirst ? AppColors.primary600 : AppColors.accent600;
    final indicatorColor = isFirst ? AppColors.primary500 : AppColors.accent500;
    final item = isFirst ? round?.itemA : round?.itemB;
    final unit = ref.watch(currentCollectionProvider).requireValue.unit;

    return InkWell(
      onTap: item != null
          ? () => showDialog(
              context: context,
              builder: (context) => ItemDetailsDialog(
                item: item,
                showExtra: round?.isCompleted ?? false,
              ),
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
                  // rounded corners
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.title ?? '',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.neutral900,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item?.subtitle ?? '',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.neutral600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (round != null && round!.isCompleted) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${item?.value.toStringAsFixed(2) ?? ''} $unit',
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
