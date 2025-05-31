import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomRatioField extends ConsumerStatefulWidget {
  const CustomRatioField({
    required this.onRatioChanged,
    required this.initialRatio,
    required this.firstItemTitle,
    required this.secondItemTitle,
    required this.firstItemColor,
    required this.secondItemColor,
    super.key,
  });

  final void Function(double ratio) onRatioChanged;
  final double initialRatio;
  final String firstItemTitle;
  final String secondItemTitle;
  final Color firstItemColor;
  final Color secondItemColor;

  @override
  ConsumerState<CustomRatioField> createState() => _CustomRatioFieldState();
}

class _CustomRatioFieldState extends ConsumerState<CustomRatioField> {
  late double _ratio;
  late double _firstSquareSize;
  late double _secondSquareSize;

  // Track which square is being updated during a gesture
  bool? _isUpdatingFirstSquare;

  late double _maxSquareSize;
  final double _minSquareSize = 12.0;

  @override
  void initState() {
    super.initState();
    _ratio = widget.initialRatio;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _maxSquareSize = MediaQuery.of(context).size.width;
    debugPrint(
        'Max square size: $_maxSquareSize, Min square size: $_minSquareSize');
    _updateSquareSizes();
  }

  void _updateSquareSizes() {
    // For nested squares, we still want to maintain the proper ratio
    // but we need to calculate sizes differently since one will be inside the other

    // For clarity in visualization, we'll make the square size proportional to their area
    // For a ratio of A:B where A is 3x bigger than B, the area of A should be 3x the area of B

    // Calculate sizes so that the areas respect the ratio
    final double sqrtRatio = _ratio >= 1 ? sqrt(_ratio) : 1 / sqrt(1 / _ratio);

    if (_ratio >= 1) {
      // First item has higher carbon impact
      _firstSquareSize = _maxSquareSize; // Outer square
      _secondSquareSize = _maxSquareSize / sqrtRatio; // Inner square

      // Ensure minimum size
      if (_secondSquareSize < _minSquareSize) {
        _secondSquareSize = _minSquareSize;
        _firstSquareSize = _minSquareSize * sqrtRatio;
      }
    } else {
      // Second item has higher carbon impact
      _secondSquareSize = _maxSquareSize; // Outer square
      _firstSquareSize = _maxSquareSize * sqrtRatio; // Inner square

      // Ensure minimum size
      if (_firstSquareSize < _minSquareSize) {
        _firstSquareSize = _minSquareSize;
        _secondSquareSize = _minSquareSize / sqrtRatio;
      }
    }
  }

  void _updateRatio(double newRatio) {
    setState(() {
      _ratio = newRatio;
      _updateSquareSizes();
      widget.onRatioChanged(_ratio);
    });
  }

  void _handleScaleUpdate(bool isFirstSquare, ScaleUpdateDetails details) {
    final double scaleFactor = details.scale;

    // Only respond to meaningful scale changes
    if (scaleFactor > 0.98 && scaleFactor < 1.02) return;

    // For nested squares, we need to adjust the sensitivity to make it feel natural
    // Use a dampened scale factor to make the interaction smoother
    const dampFactor = 0.1;

    final double dampedScale = scaleFactor > 1.0
        ? 1.0 + (scaleFactor - 1.0) * dampFactor // Scale up more gently
        : 1.0 - (1.0 - scaleFactor) * dampFactor; // Scale down more gently

    double newRatio = isFirstSquare
        ? _ratio * dampedScale // Scale the first square (numerator)
        : _ratio / dampedScale; // Scale the second square (denominator)

    // Limit the ratio to a reasonable range
    newRatio = newRatio.clamp(0.001, 1000.0);

    // Round to 3 decimal places for better UX
    newRatio = double.parse(newRatio.toStringAsFixed(3));

    _updateRatio(newRatio);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: _buildNestedSquares(),
    );
  }

  Widget _buildNestedSquares() {
    // Determine which square is larger
    final bool isFirstLarger = _firstSquareSize >= _secondSquareSize;
    final double largerSize =
        isFirstLarger ? _firstSquareSize : _secondSquareSize;
    final double smallerSize =
        isFirstLarger ? _secondSquareSize : _firstSquareSize;
    final Color largerColor =
        isFirstLarger ? widget.firstItemColor : widget.secondItemColor;
    final Color smallerColor =
        isFirstLarger ? widget.secondItemColor : widget.firstItemColor;

    // Determine which square is currently being manipulated (if any)
    final bool isLargerActive =
        (_isUpdatingFirstSquare == true && isFirstLarger) ||
            (_isUpdatingFirstSquare == false && !isFirstLarger);
    final bool isSmallerActive =
        (_isUpdatingFirstSquare == true && !isFirstLarger) ||
            (_isUpdatingFirstSquare == false && isFirstLarger);

    return GestureDetector(
      onScaleStart: (ScaleStartDetails startDetails) {
        // Determine which square is being manipulated at the start of the gesture
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box == null) return;

        final Offset center = box.size.center(Offset.zero);
        final Offset localPosition = box.globalToLocal(startDetails.focalPoint);
        final Offset centeredPosition = localPosition - center;
        final double distanceFromCenter = centeredPosition.distance;

        // Calculate the threshold - halfway between inner and outer square
        final double threshold =
            smallerSize / 2 + (largerSize - smallerSize) / 4;

        // If pointer is closer to the center than the threshold, we're interacting with inner square
        final bool isInteractingWithInnerSquare =
            distanceFromCenter < threshold;

        // If first square is larger and we're interacting with outer area, or
        // if second square is larger and we're interacting with inner area
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
      onScaleEnd: (_) {
        // Reset the tracking state when gesture ends
        debugPrint(
          '\tlargerSize: $largerSize\n'
          '\tsmallerSize: $smallerSize\n'
          '\tratio: $_ratio\n'
          '\tvisualized ratio: ${(largerSize * largerSize) / (smallerSize * smallerSize)}',
        );
        setState(() {
          _isUpdatingFirstSquare = null;
        });
      },
      child: SizedBox(
        width: largerSize,
        height: largerSize,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Larger square (background)
              _buildLargeSquare(
                  largerSize, largerColor, isLargerActive, isFirstLarger),
              // Smaller square (foreground)
              _buildSmallSquare(
                  smallerSize, largerSize, smallerColor, isSmallerActive, isFirstLarger),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLargeSquare(double largerSize, Color largerColor,
      bool isLargerActive, bool isFirstLarger) {
    return Container(
      width: largerSize,
      height: largerSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: largerColor,
          width: isLargerActive ? 5.0 : 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: largerColor,
            blurRadius: 8.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Align(
        alignment: isFirstLarger ? Alignment.topCenter : Alignment.bottomCenter,
        child: Text(
          isFirstLarger ? widget.firstItemTitle : widget.secondItemTitle,
          style: TextStyle(color: largerColor),
        ),
      ),
    );
  }

  Container _buildSmallSquare(double smallerSize, double largerSize, Color smallerColor,
      bool isSmallerActive, bool isFirstLarger) {
    return Container(
      width: smallerSize,
      height: smallerSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: smallerColor,
          width: isSmallerActive ? 5.0 : 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: smallerColor,
            blurRadius: 8.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Transform.translate(
        offset: (smallerSize < 0.8 * largerSize) ? isFirstLarger ? const Offset(0, 24) : const Offset(0, -24) : Offset.zero,
        child: Align(
          alignment:
              isFirstLarger ? Alignment.bottomCenter : Alignment.topCenter,
          child: Text(
            isFirstLarger ? widget.secondItemTitle : widget.firstItemTitle,
            style: TextStyle(color: smallerColor),
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

/// Provider to sync the CustomRatioField with a TextEditingController
class RatioController extends StateNotifier<double> {
  RatioController(super.initialRatio);

  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void updateRatio(double newRatio) {
    state = newRatio;
    // Update text controller without triggering listeners
    textController.value = TextEditingValue(
      text: newRatio.toStringAsFixed(2),
      selection:
          TextSelection.collapsed(offset: newRatio.toStringAsFixed(2).length),
    );
  }

  void updateFromText(String text) {
    if (text.isEmpty) return;

    final double? parsedValue = double.tryParse(text);
    if (parsedValue != null && parsedValue > 0) {
      state = parsedValue;
    }
  }

  void initialize() {
    textController.text = state.toStringAsFixed(2);
    textController.addListener(() {
      updateFromText(textController.text);
    });
  }
}

final ratioControllerProvider =
    StateNotifierProvider.family<RatioController, double, double>(
  (ref, initialRatio) => RatioController(initialRatio)..initialize(),
);

/// A widget that combines the CustomRatioField with a TextFormField for manual input
class CombinedRatioField extends ConsumerWidget {
  const CombinedRatioField({
    required this.initialRatio,
    required this.firstItemTitle,
    required this.secondItemTitle,
    required this.firstItemColor,
    required this.secondItemColor,
    required this.onRatioChanged,
    super.key,
  });

  final double initialRatio;
  final String firstItemTitle;
  final String secondItemTitle;
  final Color firstItemColor;
  final Color secondItemColor;
  final void Function(double ratio) onRatioChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratioController =
        ref.watch(ratioControllerProvider(initialRatio).notifier);
    final ratio = ref.watch(ratioControllerProvider(initialRatio));

    return Column(
      children: [
        CustomRatioField(
          initialRatio: ratio,
          firstItemTitle: firstItemTitle,
          secondItemTitle: secondItemTitle,
          firstItemColor: firstItemColor,
          secondItemColor: secondItemColor,
          onRatioChanged: (newRatio) {
            ratioController.updateRatio(newRatio);
            onRatioChanged(newRatio);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180, // Width constrained to be reasonable on mobile
              child: TextFormField(
                controller: ratioController.textController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Ratio value',
                  hintText: 'Enter ratio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixText: ':1',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                onChanged: (value) {
                  final double? parsedValue = double.tryParse(value);
                  if (parsedValue != null && parsedValue > 0) {
                    onRatioChanged(parsedValue);
                  }
                },
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
