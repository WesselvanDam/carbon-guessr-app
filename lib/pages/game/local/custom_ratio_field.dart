import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game/game_round.dart';
import 'game_timer_provider.dart';
import 'ratio_controller.dart';

class CustomRatioField extends ConsumerStatefulWidget {
  const CustomRatioField({
    required this.round,
    required this.minRatio,
    super.key,
  });

  final GameRound round;
  final double minRatio;

  @override
  ConsumerState<CustomRatioField> createState() => _CustomRatioFieldState();
}

class _CustomRatioFieldState extends ConsumerState<CustomRatioField> {
  // Track pointer locations
  final Map<int, Offset> _pointerLocations = {};

  // Track which square is being updated during a gesture
  bool? _isUpdatingFirstSquare;

  void _handleScaleUpdate(bool isFirstSquare, ScaleUpdateDetails details) {
    final double scaleFactor = details.scale;

    // Only respond to meaningful scale changes
    if (scaleFactor > 0.98 && scaleFactor < 1.02) return;

    // Use a dampened scale factor to make the interaction smoother
    const dampFactor = 0.1;

    final double dampedScale = scaleFactor > 1.0
        ? 1.0 + (scaleFactor - 1.0) * dampFactor // Scale up more gently
        : 1.0 - (1.0 - scaleFactor) * dampFactor; // Scale down more gently

    // Get the current ratio from the provider
    final ratio = ref.read(ratioControllerProvider);

    double newRatio = isFirstSquare
        ? ratio * dampedScale // Scale the first square (numerator)
        : ratio / dampedScale; // Scale the second square (denominator)

    // Limit the ratio to a reasonable range
    newRatio = newRatio.clamp(widget.minRatio, 1 / widget.minRatio);

    // Round the ratio to four decimal places for consistency
    newRatio = double.parse(newRatio.toStringAsFixed(4));

    // Update the ratio in the provider
    ref.read(ratioControllerProvider.notifier).set(newRatio);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get the available size for the container
          final containerSize = constraints.maxWidth;

          // Get the current ratio from the provider
          final ratio = ref.watch(ratioControllerProvider);

          // Calculate the size of the smaller square based on the ratio
          final sqrtRatio = ratio >= 1 ? sqrt(ratio) : 1 / sqrt(1 / ratio);
          final smallerSizeProportion = ratio >= 1 ? 1 / sqrtRatio : sqrtRatio;

          // Ensure the smaller square is not too small
          final adjustedSmallerProportion =
              smallerSizeProportion.clamp(widget.minRatio, 1 / widget.minRatio);

          final smallerSize = containerSize * adjustedSmallerProportion;
          final isFirstLarger = ratio >= 1;

          return Listener(
            onPointerDown: (event) =>
                _pointerLocations[event.pointer] = event.position,
            onPointerMove: (PointerMoveEvent event) =>
                _pointerLocations[event.pointer] = event.position,
            onPointerUp: (PointerUpEvent event) =>
                _pointerLocations.remove(event.pointer),
            onPointerCancel: (PointerCancelEvent event) =>
                _pointerLocations.remove(event.pointer),
            child: GestureDetector(
              onScaleStart: (ScaleStartDetails startDetails) {
                // Determine which square is being manipulated at the start of the gesture
                final RenderBox? box = context.findRenderObject() as RenderBox?;
                if (box == null) return;
                if (startDetails.pointerCount != 2 ||
                    _pointerLocations.length != 2) {
                  // Only handle two-finger gestures
                  setState(() => _isUpdatingFirstSquare = null);
                  return;
                }

                final Offset center = box.size.center(Offset.zero);
                // Convert global pointer positions to local and calculate distances to center
                final positions = _pointerLocations.values.toList();
                final localPos1 = box.globalToLocal(positions[0]);
                final localPos2 = box.globalToLocal(positions[1]);
                final distance1 = (localPos1 - center).distance;
                final distance2 = (localPos2 - center).distance;
                final double distanceFromCenter = (distance1 + distance2) / 2;

                // Make the threshold halfway between the inner and outer square
                final double threshold =
                    smallerSize / 2 + (containerSize - smallerSize) / 4;

                // If pointer is closer to the center than the threshold, we're interacting with inner square
                final bool isInteractingWithInnerSquare =
                    distanceFromCenter < threshold;

                setState(() {
                  _isUpdatingFirstSquare =
                      (isFirstLarger && !isInteractingWithInnerSquare) ||
                          (!isFirstLarger && isInteractingWithInnerSquare);
                });
              },
              onScaleUpdate: (details) {
                // Only proceed if we've determined which square is being updated
                if (_isUpdatingFirstSquare == null) return;

                _handleScaleUpdate(_isUpdatingFirstSquare!, details);
              },
              onScaleEnd: (_) => setState(() => _isUpdatingFirstSquare = null),
              child: SizedBox(
                width: containerSize,
                height: containerSize,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildLargeSquare(
                          containerSize,
                          (_isUpdatingFirstSquare == true && isFirstLarger) ||
                              (_isUpdatingFirstSquare == false &&
                                  !isFirstLarger),
                          isFirstLarger),
                      _buildSmallSquare(
                          smallerSize,
                          containerSize,
                          (_isUpdatingFirstSquare == true && !isFirstLarger) ||
                              (_isUpdatingFirstSquare == false &&
                                  isFirstLarger),
                          isFirstLarger),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _buildLargeSquare(double size, bool isActive, bool isFirstLarger) {
    final squareColor = isFirstLarger
        ? Theme.of(context).colorScheme.secondaryContainer
        : Theme.of(context).colorScheme.tertiaryContainer;
    final onSquareColor = isFirstLarger
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.onTertiaryContainer;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: squareColor,
        border: Border.all(
          color: isActive
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Align(
        alignment: isFirstLarger ? Alignment.topCenter : Alignment.bottomCenter,
        child: Text(
          isFirstLarger
              ? widget.round.itemPair.itemA.title
              : widget.round.itemPair.itemB.title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: onSquareColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Container _buildSmallSquare(double smallerSize, double largerSize,
      bool isActive, bool isFirstLarger) {
    final squareColor = isFirstLarger
        ? Theme.of(context).colorScheme.tertiaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;
    final onSquareColor = isFirstLarger
        ? Theme.of(context).colorScheme.onTertiaryContainer
        : Theme.of(context).colorScheme.onSecondaryContainer;
    return Container(
      width: smallerSize,
      height: smallerSize,
      decoration: BoxDecoration(
        color: squareColor,
        border: Border.all(
          color: isActive
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(16.0 * (smallerSize / largerSize)),
      ),
      child: Transform.translate(
        offset: (smallerSize < 0.8 * largerSize)
            ? isFirstLarger
                ? const Offset(0, 24)
                : const Offset(0, -24)
            : Offset.zero,
        child: Align(
          alignment:
              isFirstLarger ? Alignment.bottomCenter : Alignment.topCenter,
          child: Text(
            isFirstLarger
                ? widget.round.itemPair.itemB.title
                : widget.round.itemPair.itemA.title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: onSquareColor,
                  fontWeight: FontWeight.bold,
                ),
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
