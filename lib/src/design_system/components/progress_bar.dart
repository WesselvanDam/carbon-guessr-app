import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

/// A reusable progress bar component that displays a horizontal progress indicator.
///
/// The progress bar features:
/// - A subtle inner shadow effect for depth
/// - Smooth animations when progress changes
/// - Rounded corners matching the app's design system
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.progress,
    this.height = 16,
    this.backgroundColor,
    this.progressColor,
    this.borderColor,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    super.key,
  });

  /// The progress value, ranging from 0.0 (empty) to 1.0 (full).
  final double progress;

  /// The height of the progress bar. Defaults to 16.
  final double height;

  /// Background color of the progress bar. Defaults to [AppColors.neutral50].
  final Color? backgroundColor;

  /// Color of the progress indicator. Defaults to [AppColors.primary600].
  final Color? progressColor;

  /// Border color of the progress bar. Defaults to [AppColors.neutral200].
  final Color? borderColor;

  /// Border radius of the progress bar. Defaults to 8.
  final BorderRadius? borderRadius;

  /// Duration of the animation when progress changes.
  final Duration animationDuration;

  /// Curve of the animation when progress changes.
  final Curve animationCurve;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(8);
    final innerBorderRadius = BorderRadius.circular(
      (effectiveBorderRadius.topLeft.x - 1).clamp(0, double.infinity),
    );

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutral50,
        borderRadius: effectiveBorderRadius,
        border: Border.all(color: borderColor ?? AppColors.neutral200),
      ),
      child: ClipRRect(
        borderRadius: innerBorderRadius,
        child: Stack(
          children: [
            // Inner shadow effect
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x10000000), Colors.transparent],
                ),
              ),
            ),
            // Progress indicator
            LayoutBuilder(
              builder: (context, constraints) {
                final clampedProgress = progress.clamp(0.0, 1.0);
                return AnimatedContainer(
                  duration: animationDuration,
                  curve: animationCurve,
                  width: constraints.maxWidth * clampedProgress,
                  decoration: BoxDecoration(
                    color: progressColor ?? AppColors.primary600,
                    borderRadius: innerBorderRadius,
                    boxShadow: const [
                      BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
