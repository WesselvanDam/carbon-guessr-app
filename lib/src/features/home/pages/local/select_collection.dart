import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_shadows.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../providers/collections.dart';
import 'collection_card.dart';

class CollectionSelector extends ConsumerWidget {
  const CollectionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);

    return collections.when(
      data: (data) {
        final collections = data.values.toList();
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: collections.length + 1,
          itemBuilder: (context, index) {
            if (index == collections.length) {
              // "More coming soon" card
              return DashedBorder(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neutral100,
                        ),
                        child: const Icon(
                          Symbols.hourglass_top,
                          color: AppColors.neutral400,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'More Coming Soon!',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.neutral900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All kinds of collections are on their way.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return CollectionCard(collection: collections[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

/// Widget to create a dashed border effect
class DashedBorder extends StatelessWidget {
  const DashedBorder({
    required this.child,
    super.key,
    this.color = AppColors.neutral200,
    this.strokeWidth = 2,
    this.dashWidth = 8,
    this.dashSpace = 4,
    this.borderRadius = 24,
  });

  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  const DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final dashPath = Path();
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final start = metric.getTangentForOffset(distance)?.position;
        distance += dashWidth;
        final end = metric.getTangentForOffset(distance)?.position;
        if (start != null && end != null) {
          dashPath.moveTo(start.dx, start.dy);
          dashPath.lineTo(end.dx, end.dy);
        }
        distance += dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
