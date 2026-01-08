import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../design_system/app_colors.dart';
import '../../design_system/app_shadows.dart';
import '../../design_system/app_typography.dart';

/// Collection card widget for displaying collection information on the home page
class CollectionCard extends StatelessWidget {
  const CollectionCard({
    required this.title,
    required this.description,
    required this.categoryLabel,
    required this.itemCount,
    required this.unit,
    required this.icon,
    required this.onTap,
    super.key,
    this.averageScore,
    this.proficiencyLabel,
    this.isNew = false,
    this.accentColor = AppColors.primary,
  });

  final String title;
  final String description;
  final String categoryLabel;
  final int itemCount;
  final String unit;
  final IconData icon;
  final VoidCallback onTap;
  final int? averageScore;
  final String? proficiencyLabel;
  final bool isNew;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final hasScore = averageScore != null;
    final scorePercent = hasScore ? (averageScore! / 500 * 100).round() : 0;
    final progressValue = hasScore ? (100 - scorePercent) / 100 : 1.0;

    return InkWell(
      onTap: onTap,
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
                              title,
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
                                categoryLabel.toUpperCase(),
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
                    description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textLight,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    children: [
                      _StatChip(
                        icon: Symbols.dataset,
                        label: '$itemCount Items',
                      ),
                      const SizedBox(width: 8),
                      _StatChip(icon: Symbols.scale, label: unit),
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
                        // Score display
                        if (hasScore)
                          Row(
                            children: [
                              // Circular progress
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  children: [
                                    // Background circle
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: const CircularProgressIndicator(
                                        value: 1.0,
                                        strokeWidth: 4,
                                        color: AppColors.slate100,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    // Progress circle
                                    CircularProgressIndicator(
                                      value: progressValue,
                                      strokeWidth: 4,
                                      strokeCap: StrokeCap.round,
                                      color: scorePercent >= 80
                                          ? AppColors.green500
                                          : AppColors.orange400,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    // Score text
                                    Center(
                                      child: Text(
                                        '$averageScore',
                                        style: AppTypography.labelSmall
                                            .copyWith(
                                              fontWeight: FontWeight.w900,
                                            ),
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
                                    'AVG SCORE / 500',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.slate400,
                                    ),
                                  ),
                                  Text(
                                    proficiencyLabel ?? '',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
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
        color: AppColors.slate50,
        border: Border.all(color: AppColors.slate100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.slate500),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(color: AppColors.slate500),
          ),
        ],
      ),
    );
  }
}
