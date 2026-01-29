import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../data/models/collection.model.dart';
import '../../../../../router/routes.dart';
import '../../../../design_system/components/chips/info_chip.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_shadows.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../../shared/utils/extensions.dart';

class CollectionCard extends ConsumerWidget {
  const CollectionCard({required this.collection, super.key});

  final CollectionModel collection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: collection.id == 'onboarding_collection'
          ? null
          : () => CollectionRoute(cid: collection.id).go(context),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.neutral100),
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
                decoration: const BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.only(
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
                  Text(
                    collection.title.toTitleCase(),
                    style: AppTypography.h4.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InfoChip.primary(label: collection.quantity.toUpperCase()),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    collection.tagline,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.neutral500,
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    spacing: 8,
                    children: [
                      InfoChip.neutral(
                        icon: Symbols.dataset,
                        label: '${collection.size} Items',
                      ),
                      InfoChip.neutral(
                        icon: Symbols.scale,
                        label: collection.unit,
                      ),
                      if (collection.isSaved)
                        InfoChip.neutral(
                          icon: Symbols.cloud_download,
                          label: 'Saved',
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Score section
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.neutral200),
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
                                  color: AppColors.neutral200,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Symbols.remove,
                                color: AppColors.neutral300,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AVG SCORE',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.neutral400,
                                  ),
                                ),
                                Text(
                                  'Not played yet',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.neutral400,
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary600,
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
