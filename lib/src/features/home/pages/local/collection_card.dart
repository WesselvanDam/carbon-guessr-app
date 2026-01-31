import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'dart:math' as math;
import '../../../../../data/models/collection.model.dart';
import '../../../../../router/routes.dart';
import '../../../../design_system/components/chips/info_chip.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_shadows.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../stats/providers/stats.dart';

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
                        top: BorderSide(color: AppColors.neutral100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatBox(cid: collection.id),
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

class _StatBox extends ConsumerWidget {
  const _StatBox({required this.cid});

  final String cid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider.select((value) => value.value?[cid]));
    final hasScore = stats != null && stats.averageScore != null;

    // Calculate progress and color
    final progress = hasScore
        ? (stats.averageScore! / 500).clamp(0.0, 1.0)
        : 0.0;
    final percentage = progress * 100;

    final (Color progressColor, Color trackColor) = switch (percentage) {
      < 50 => (AppColors.error500, AppColors.error100),
      < 80 => (AppColors.warning500, AppColors.warning100),
      _ => (AppColors.success500, AppColors.success100),
    };

    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            children: [
              // Progress arc
              if (hasScore)
                CircularProgressIndicator(
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  strokeAlign: -1,
                  value: progress,
                  strokeWidth: 4,
                  color: progressColor,
                  backgroundColor: trackColor,
                  trackGap: 4,
                  strokeCap: StrokeCap.round,
                ),
              if (!hasScore)
                // Base circle
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: hasScore
                          ? AppColors.neutral200
                          : AppColors.neutral200,
                      width: 2,
                    ),
                  ),
                ),
              // Score display
              Center(
                child: hasScore
                    ? Text(
                        stats.averageScore.toString(),
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.neutral900,
                          fontVariations: const [FontVariation('wght', 800)],
                        ),
                      )
                    : const Icon(
                        Symbols.remove,
                        color: AppColors.neutral300,
                        size: 16,
                      ),
              ),
            ],
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
              hasScore
                  ? '${stats.gamesFinished} game${stats.gamesFinished == 1 ? '' : 's'} finished'
                  : 'Not played yet',
              style: AppTypography.bodySmall.copyWith(
                color: hasScore ? AppColors.neutral900 : AppColors.neutral400,
                fontVariations: const [FontVariation('wght', 700)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
