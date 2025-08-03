import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_controller.dart';
import 'ratio_controller.dart';
import 'timer_controller.dart';

class CustomRatioField extends ConsumerStatefulWidget {
  // correctRatio is no longer needed here
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
    final newRatio =
        isFirstSquare ? ratio * relativeScale : ratio / relativeScale;
    ref.read(ratioControllerProvider.notifier).set(newRatio);

    // Update _previousScale for the next update
    _previousScale = details.scale;
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the timer to trigger the "show correct answer" animation
    ref.listen(
        timerControllerProvider.select(
          (value) => value == 0,
        ), (_, isRoundOver) {
      setState(() {
        _correctRatio = isRoundOver
            ? ref.read(gameControllerProvider).value!.currentRound.correctRatio
            : null;
        _isUpdatingFirstSquare = isRoundOver ? null : _isUpdatingFirstSquare;
      });
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
    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerSize = constraints.maxWidth;

          final userRatio = ref.watch(ratioControllerProvider);
          final bool isFirstLargerByUser = userRatio >= 1;
          final double smallerSizeByUser = containerSize *
              (isFirstLargerByUser ? 1 / sqrt(userRatio) : sqrt(userRatio));

          final double sizeA;
          final double sizeB;
          if (currentRatio >= 1) {
            sizeA = containerSize;
            sizeB = containerSize / sqrt(currentRatio);
          } else {
            sizeA = containerSize * sqrt(currentRatio);
            sizeB = containerSize;
          }

          final squareA = _buildSquare(
            size: sizeA,
            containerSize: containerSize,
            isActive: _isUpdatingFirstSquare == true,
            isFirst: true,
          );

          final squareB = _buildSquare(
            size: sizeB,
            containerSize: containerSize,
            isActive: _isUpdatingFirstSquare == false,
            isFirst: false,
          );

          return Listener(
            onPointerDown: (event) => _pointers[event.pointer] = event.position,
            onPointerMove: (event) => _pointers[event.pointer] = event.position,
            onPointerUp: (event) => _pointers.remove(event.pointer),
            onPointerCancel: (event) => _pointers.remove(event.pointer),
            child: GestureDetector(
              onScaleStart: (details) {
                if (_correctRatio != null) {
                  return; // Use internal state for check
                }

                final RenderBox? box = context.findRenderObject() as RenderBox?;
                if (box == null ||
                    details.pointerCount != 2 ||
                    _pointers.length != 2) {
                  setState(() {
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

                final double threshold = smallerSizeByUser / 2 +
                    (containerSize - smallerSizeByUser) / 4;
                final bool isInteractingWithInnerSquare =
                    distanceFromCenter < threshold;

                setState(() {
                  _isUpdatingFirstSquare = (isFirstLargerByUser &&
                          !isInteractingWithInnerSquare) ||
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
  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  /// A single, unified builder for creating an animatable square.
  Widget _buildSquare({
    required double size,
    required double containerSize,
    required bool isActive,
    required bool isFirst,
  }) {
    final gameValue = ref.watch(gameControllerProvider).value;
    final label = gameValue == null
        ? ' '
        : isFirst
            ? gameValue.currentRound.itemA.title
            : gameValue.currentRound.itemB.title;
    final colorScheme = Theme.of(context).colorScheme;
    final Color mainContainer =
        isFirst ? colorScheme.primary : colorScheme.tertiaryContainer;
    final Color onMainContainer =
        isFirst ? colorScheme.onPrimary : colorScheme.onTertiaryFixedVariant;
    final labelStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          color: onMainContainer,
          fontWeight: FontWeight.bold,
        );
    final borderColor = isActive
        ? isFirst
            ? Color.lerp(mainContainer, colorScheme.secondary, 0.5)!
            : Color.lerp(mainContainer, colorScheme.tertiary, 0.5)!
        : colorScheme.outlineVariant;

    final double labelWidth = _calculateTextWidth(label, labelStyle);
    final labelFits = labelWidth <= size - 16.0; // 16.0 for padding

    return AnimatedContainer(
      duration: _correctRatio != null
          ? Duration.zero
          : const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mainContainer,
        border: Border.all(
          width: 2.0,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(16.0 * (size / containerSize)),
      ),
      child: Align(
        alignment: isFirst ? Alignment.topCenter : Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: labelStyle,
            softWrap: false,
            overflow: TextOverflow.visible,
          )
              .animate(target: (label.trim().isEmpty || !labelFits) ? 0 : 1)
              .fadeIn(),
        ),
      ),
    );
  }
}
