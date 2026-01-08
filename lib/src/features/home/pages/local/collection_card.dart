import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../data/models/collection.model.dart';
import '../../../../../router/routes.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_shadows.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../../../shared/utils/extensions.dart';

class CollectionCard extends ConsumerWidget {
  const CollectionCard({required this.collection, super.key});

  final CollectionModel collection;

  /// Maps collection IDs to appropriate icons and accent colors
  (IconData, Color) _getCollectionStyle() {
    // Map based on collection title/id patterns
    final title = collection.title.toLowerCase();
    final id = collection.id.toLowerCase();

    if (title.contains('everyday') ||
        id.contains('carbon') ||
        id.contains('household')) {
      return (Symbols.home_work, AppColors.primary);
    } else if (title.contains('food') ||
        title.contains('diet') ||
        id.contains('food')) {
      return (Symbols.lunch_dining, AppColors.secondary);
    } else if (title.contains('transport') || id.contains('transport')) {
      return (Symbols.directions_car, AppColors.purple600);
    } else {
      // Default
      return (Symbols.eco, AppColors.primary);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (icon, accentColor) = _getCollectionStyle();

    // Determine if this is a "new" collection (less than 30 days old)
    final isNew =
        DateTime.now()
            .difference(DateTime.parse(collection.lastUpdated))
            .inDays <
        30;

    return InkWell(
      onTap: collection.id == 'onboarding_collection'
          ? null
          : () => CollectionRoute(cid: collection.id).go(context),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.slate100),
          boxShadow: AppShadows.card,
        ),
        child: Stack(
          children: [
            // Decorative corner
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(64),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      // Icon container
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(icon, color: accentColor, size: 24),
                      ),
                      const SizedBox(width: 16),
                      // Title and category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collection.title.toTitleCase(),
                              style: AppTypography.h4.copyWith(
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                border: Border.all(
                                  color: accentColor.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                collection.quantity
                                    .toSentenceCase()
                                    .toUpperCase(),
                                style: AppTypography.labelSmall.copyWith(
                                  color: accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // New badge
                      if (isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: AppShadows.sm,
                          ),
                          child: Text(
                            'NEW',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    collection.tagline,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textLight,
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    children: [
                      _StatChip(
                        icon: Symbols.dataset,
                        label: '${collection.size} Items',
                      ),
                      const SizedBox(width: 8),
                      _StatChip(icon: Symbols.scale, label: collection.unit),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Score section
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.slate100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Score display (placeholder - not implemented yet)
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.slate100,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Symbols.remove,
                                color: AppColors.slate300,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AVG SCORE / 500',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.slate400,
                                  ),
                                ),
                                Text(
                                  'Not played yet',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.slate400,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Play button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor,
                            boxShadow: AppShadows.md,
                          ),
                          child: const Icon(
                            Symbols.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bg,
        border: Border.all(color: AppColors.slate100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textLight),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
