import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/item.model.dart';
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
      builder: (context) =>
          ItemDetailsDialog(item: item, showValue: false, showSources: false),
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

    if (round == null) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerSize = constraints.maxWidth;

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
              child: SizedBox(
                width: containerSize,
                height: containerSize,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: currentRatio >= 1
                        ? [squareA, squareB]
                        : [squareB, squareA],
                  ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final Color mainContainer = isFirst
        ? colorScheme.primary
        : colorScheme.tertiaryContainer;
    final Color onMainContainer = isFirst
        ? colorScheme.onPrimary
        : colorScheme.onTertiaryFixedVariant;

    final labelStyle = textTheme.titleMedium!.copyWith(
      color: onMainContainer,
      fontWeight: FontWeight.bold,
    );
    final categoryStyle = textTheme.labelLarge!.copyWith(
      color: onMainContainer.withAlpha(220),
      fontWeight: FontWeight.w600,
    );

    final borderColor = isActive
        ? isFirst
              ? Color.lerp(mainContainer, colorScheme.secondary, 0.5)!
              : Color.lerp(mainContainer, colorScheme.tertiary, 0.5)!
        : colorScheme.outlineVariant;

    final padding = 16.0 * (size / containerSize);
    // Calculate max width and height for the ListView content
    final maxWidth = size - 2 * padding;
    final maxHeight = size - 2 * padding - 8 - 16;

    final labelSize = _computeTextSize(item.title, labelStyle, maxWidth);
    // If the label is too wide, the category should not be shown
    final categorySize = labelSize.width <= maxWidth
        ? _computeTextSize(
            '${item.category} · ${item.quantity}',
            categoryStyle,
            maxWidth,
          )
        : Size.infinite;

    final labelFits =
        labelSize.height <= maxHeight && labelSize.width <= maxWidth;
    final categoryFits =
        (labelSize.height + categorySize.height + 8) <= maxHeight &&
        categorySize.width <= maxWidth;

    return AnimatedContainer(
      duration: _correctRatio != null
          ? Duration.zero
          : const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mainContainer,
        border: Border.all(width: 2.0, color: borderColor),
        borderRadius: BorderRadius.circular(16.0 * (size / containerSize)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPadding(
            duration: 100.milliseconds,
            padding: .all(padding),
            child: ListView(
              padding: .zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  item.title,
                  style: labelStyle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: .visible,
                ).animate(target: labelFits ? 1 : 0).fadeIn(),
                const SizedBox(height: 8.0),
                Text(
                  '${item.category} · ${item.quantity}',
                  style: categoryStyle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: .visible,
                ).animate(target: categoryFits ? 1 : 0).fadeIn(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.info_outline, size: 18, color: onMainContainer),
              style: TextButton.styleFrom(
                padding: const .all(8),
                tapTargetSize: .shrinkWrap,
              ),
              onPressed: () => _showItemDetailsDialog(context, item),
            ).animate(target: size > 48 ? 1 : 0).fadeIn(),
          ),
        ],
      ),
    );
  }
}
