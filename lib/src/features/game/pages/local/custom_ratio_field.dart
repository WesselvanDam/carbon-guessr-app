import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../data/models/item.model.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../controllers/game_controller.dart';
import '../../controllers/ratio_controller.dart';
import '../../controllers/timer_controller.dart';
import 'item_details_dialog.dart';

class CustomRatioField extends ConsumerStatefulWidget {
  const CustomRatioField({super.key});

  @override
  ConsumerState<CustomRatioField> createState() => _CustomRatioFieldState();
}

class _CustomRatioFieldState extends ConsumerState<CustomRatioField> {
  // Internal state to hold the correct ratio when it's time to animate
  double? _correctRatio;

  // Track pointer locations
  final Map<int, Offset> _pointers = {};

  // Track which square is being updated during a gesture
  bool? _isUpdatingFirstSquare;

  // Track the previous scale for relative scaling
  double? _previousScale;

  void _handleScaleUpdate(bool isFirstSquare, ScaleUpdateDetails details) {
    // Disable interaction while animating to the correct ratio
    if (_correctRatio != null) return;

    // If this is the first update in a gesture, initialize _previousScale
    _previousScale ??= details.scale;

    // Calculate the relative scale since the last update
    final double relativeScale = details.scale / _previousScale!;

    final ratio = ref.read(ratioControllerProvider);
    final newRatio = isFirstSquare
        ? ratio * relativeScale
        : ratio / relativeScale;
    ref.read(ratioControllerProvider.notifier).set(newRatio);

    // Update _previousScale for the next update
    _previousScale = details.scale;
  }

  void _showItemDetailsDialog(BuildContext context, ItemModel item) {
    showDialog(
      context: context,
      builder: (context) => ItemDetailsDialog(item: item, showExtra: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the timer to trigger the "show correct answer" animation
    ref.listen(timerControllerProvider.select((value) => value == 0), (
      _,
      isRoundOver,
    ) {
      if (mounted) {
        setState(() {
          _correctRatio = isRoundOver
              ? ref
                    .read(gameControllerProvider)
                    .value!
                    .currentRound
                    .correctRatio
              : null;
          _isUpdatingFirstSquare = isRoundOver ? null : _isUpdatingFirstSquare;
        });
      }
    });

    final userRatio = ref.watch(ratioControllerProvider);

    // If _correctRatio is set, animate from the user's ratio to the correct one.
    // Otherwise, just display the current user ratio.
    if (_correctRatio != null) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: userRatio, end: _correctRatio),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOutCubic,
        builder: (context, animatedRatio, child) =>
            _buildRatioUI(context, animatedRatio),
      );
    } else {
      return _buildRatioUI(context, userRatio);
    }
  }

  /// Builds the UI based on a given ratio (which can be static or animated).
  Widget _buildRatioUI(BuildContext context, double currentRatio) {
    final round = ref.read(
      gameControllerProvider.select((game) => game.value?.currentRound),
    );

    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerSize = constraints.maxWidth;

          if (round == null) {
            return SizedBox.square(dimension: containerSize);
          }

          final userRatio = ref.watch(ratioControllerProvider);
          final bool isFirstLargerByUser = userRatio >= 1;
          final double smallerSizeByUser =
              containerSize *
              (isFirstLargerByUser ? 1 / sqrt(userRatio) : sqrt(userRatio));

          final sizeA = currentRatio >= 1
              ? containerSize
              : containerSize * sqrt(currentRatio);
          final sizeB = currentRatio >= 1
              ? containerSize / sqrt(currentRatio)
              : containerSize;

          final squareA = _buildSquare(
            size: sizeA,
            containerSize: containerSize,
            isActive: _isUpdatingFirstSquare == true,
            isFirst: true,
            item: round.itemA,
            otherSize: sizeB,
          );

          final squareB = _buildSquare(
            size: sizeB,
            containerSize: containerSize,
            isActive: _isUpdatingFirstSquare == false,
            isFirst: false,
            item: round.itemB,
            otherSize: sizeA,
          );

          return Listener(
            onPointerDown: (event) => _pointers[event.pointer] = event.position,
            onPointerMove: (event) => _pointers[event.pointer] = event.position,
            onPointerUp: (event) => _pointers.remove(event.pointer),
            onPointerCancel: (event) => _pointers.remove(event.pointer),
            child: GestureDetector(
              onScaleStart: (details) {
                if (_correctRatio != null) {
                  // Disable interaction while animating to the correct ratio
                  return;
                }

                final RenderBox? box = context.findRenderObject() as RenderBox?;
                if (box == null ||
                    details.pointerCount != 2 ||
                    _pointers.length != 2) {
                  setState(() {
                    // Disable interaction if not exactly two pointers are down
                    _isUpdatingFirstSquare = null;
                    _previousScale = null;
                  });
                  return;
                }

                final Offset center = box.size.center(Offset.zero);
                final positions = _pointers.values.toList();
                final localPos1 = box.globalToLocal(positions[0]);
                final localPos2 = box.globalToLocal(positions[1]);
                final double distanceFromCenter =
                    ((localPos1 - center).distance +
                        (localPos2 - center).distance) /
                    2;

                final double threshold =
                    smallerSizeByUser / 2 +
                    (containerSize - smallerSizeByUser) / 4;
                final bool isInteractingWithInnerSquare =
                    distanceFromCenter < threshold;

                setState(() {
                  _isUpdatingFirstSquare =
                      (isFirstLargerByUser && !isInteractingWithInnerSquare) ||
                      (!isFirstLargerByUser && isInteractingWithInnerSquare);
                  _previousScale = 1.0;
                });
              },
              onScaleUpdate: (details) {
                if (_isUpdatingFirstSquare == null) return;
                _handleScaleUpdate(_isUpdatingFirstSquare!, details);
              },
              onScaleEnd: (_) => setState(() {
                _isUpdatingFirstSquare = null;
                _previousScale = null;
              }),
              child: Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: currentRatio >= 1
                      ? [squareA, squareB]
                      : [squareB, squareA],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Calculates the width of a text string given a style.
  Size _computeTextSize(String text, TextStyle style, double maxWidth) {
    if (maxWidth < 48) return Size.infinite;
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    if (textPainter.didExceedMaxLines) {
      return Size.infinite;
    }
    return textPainter.size;
  }

  /// A single, unified builder for creating an animatable square.
  Widget _buildSquare({
    required double size,
    required double containerSize,
    required bool isActive,
    required bool isFirst,
    required ItemModel item,
    required double otherSize,
  }) {
    final Color mainContainer = isFirst
        ? AppColors.primary600
        : AppColors.accent600;
    final Color borderColor = isFirst
        ? AppColors.primary800
        : AppColors.accent800;
    const Color onMainContainer = Colors.white;

    final padding = 16.0 * (size / containerSize);
    // Calculate max width and height for the ListView content
    final maxWidth = size - 2 * padding;
    final maxHeight = size - 2 * padding - 8 - 16;

    final titleText = item.title;
    final subtitleText = item.subtitle;

    final titleStyle = AppTypography.h4.copyWith(color: onMainContainer);
    final subtitleStyle = AppTypography.labelLarge.copyWith(
      color: onMainContainer.withOpacity(0.9),
      fontWeight: FontWeight.w700,
    );

    final titleSize = _computeTextSize(titleText, titleStyle, maxWidth);
    // If the label is too wide, the category should not be shown
    final subtitleSize = titleSize.width <= maxWidth
        ? _computeTextSize(subtitleText, subtitleStyle, maxWidth)
        : Size.infinite;

    final titleFits =
        titleSize.height <= maxHeight && titleSize.width <= maxWidth;
    final subtitleFits =
        (titleSize.height + subtitleSize.height + 8) <= maxHeight &&
        subtitleSize.width <= maxWidth;

    final scaledBorderRadius = 24.0 * (size / containerSize);

    return AnimatedContainer(
      duration: _correctRatio != null
          ? Duration.zero
          : const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mainContainer,
        border: Border.all(width: 4.0, color: borderColor),
        borderRadius: BorderRadius.circular(scaledBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Diagonal pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: DiagonalPatternPainter(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // Content
          AnimatedPadding(
            duration: 100.milliseconds,
            padding: EdgeInsets.all(padding),
            child: ListView(
              padding: .zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  titleText,
                  style: titleStyle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: .visible,
                ).animate(target: titleFits ? 1 : 0).fadeIn(),
                const SizedBox(height: 4),
                Text(
                  subtitleText,
                  style: subtitleStyle,
                  softWrap: true,
                  maxLines: 1,
                  overflow: .visible,
                ).animate(target: subtitleFits ? 1 : 0).fadeIn(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Symbols.info, size: 24, color: onMainContainer),
              style: TextButton.styleFrom(
                padding: const .all(8),
                tapTargetSize: .shrinkWrap,
              ),
              onPressed: () => _showItemDetailsDialog(context, item),
            ).animate(target: size > 56 ? 1 : 0).fadeIn(),
          ),
          // Corner decorations
          if (size > 80) ...[
            Positioned(
              top: 12 * (size / containerSize),
              right: 12 * (size / containerSize),
              child: Container(
                width: 16 * (size / containerSize),
                height: 16 * (size / containerSize),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 2 * (size / containerSize),
                    ),
                    right: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 2 * (size / containerSize),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4 * (size / containerSize)),
                  ),
                ),
              ).animate(target: size > 120 ? 1 : 0).fadeIn(),
            ),
            Positioned(
              bottom: 12 * (size / containerSize),
              left: 12 * (size / containerSize),
              child: Container(
                width: 16 * (size / containerSize),
                height: 16 * (size / containerSize),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 2 * (size / containerSize),
                    ),
                    left: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 2 * (size / containerSize),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4 * (size / containerSize)),
                  ),
                ),
              ).animate(target: size > 120 ? 1 : 0).fadeIn(),
            ),
          ],
        ],
      ),
    );
  }
}

/// Custom painter for grid pattern background
class GridPatternPainter extends CustomPainter {
  const GridPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;

    const spacing = 24.0;

    // Draw vertical lines
    for (double x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for diagonal pattern overlay
class DiagonalPatternPainter extends CustomPainter {
  const DiagonalPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 20
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const lineWidth = 10.0;

    // Draw diagonal stripes
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawRect(Rect.fromLTWH(i, 0, lineWidth, size.height * 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
