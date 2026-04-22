import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../styles/app_colors.dart';

/// Indefinite loading indicator made of two rounded squares that cycle
/// through a 2x2 box to create a circular-like motion.
class AppLoadingIndicator extends StatefulWidget {
  const AppLoadingIndicator({
    this.squareSize = 16,
    this.spacing = 0,
    this.cornerRadius = 4,
    this.phaseOneColor = AppColors.accent600,
    this.phaseTwoColor = AppColors.primary600,
    this.phaseOneDuration = const Duration(milliseconds: 700),
    this.phaseTwoDuration = const Duration(milliseconds: 700),
    this.curve = Curves.easeInOutCubic,
    this.semanticLabel = 'Loading',
    super.key,
  });

  /// Side length of each square.
  final double squareSize;

  /// Gap between the two columns/rows in the 2x2 motion box.
  final double spacing;

  /// Corner radius of each square.
  final double cornerRadius;

  /// Base color used at loop start and end.
  final Color phaseOneColor;

  /// Highlight color used during the first phase.
  final Color phaseTwoColor;

  /// Duration of phase 1:
  /// top-left -> top-right and bottom-right -> bottom-left.
  final Duration phaseOneDuration;

  /// Duration of phase 2:
  /// top-right -> bottom-right and bottom-left -> top-left.
  final Duration phaseTwoDuration;

  /// Motion curve for each phase.
  final Curve curve;

  /// Semantic label announced by assistive technologies.
  final String semanticLabel;

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Duration get _totalDuration =>
      widget.phaseOneDuration + widget.phaseTwoDuration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _totalDuration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant AppLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.phaseOneDuration != widget.phaseOneDuration ||
        oldWidget.phaseTwoDuration != widget.phaseTwoDuration) {
      _controller.duration = _totalDuration;
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicator = RepaintBoundary(
      child: SizedBox(
        width: _boxSize,
        height: _boxSize,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final frame = _frameData(_controller.value);
            return Stack(
              children: [
                Positioned(
                  left: frame.firstOffset.dx,
                  top: frame.firstOffset.dy,
                  child: _Square(
                    size: widget.squareSize,
                    radius: widget.cornerRadius,
                    color: frame.color,
                  ),
                ),
                Positioned(
                  left: frame.secondOffset.dx,
                  top: frame.secondOffset.dy,
                  child: _Square(
                    size: widget.squareSize,
                    radius: widget.cornerRadius,
                    color: frame.color,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    return Semantics(
      label: widget.semanticLabel,
      child: indicator.animate().fadeIn(duration: 180.ms),
    );
  }

  double get _step => widget.squareSize + widget.spacing;

  double get _boxSize => (widget.squareSize * 2) + widget.spacing;

  _FrameData _frameData(double rawValue) {
    final totalMicros = _totalDuration.inMicroseconds;
    final phaseOneMicros = widget.phaseOneDuration.inMicroseconds;
    final split = totalMicros == 0 ? 0.5 : phaseOneMicros / totalMicros;

    const topLeft = Offset.zero;
    final topRight = Offset(_step, 0);
    final bottomRight = Offset(_step, _step);
    final bottomLeft = Offset(0, _step);

    if (split <= 0) {
      final phaseProgress = widget.curve.transform(rawValue);
      return _FrameData(
        firstOffset:
            Offset.lerp(topRight, bottomRight, phaseProgress) ?? topRight,
        secondOffset:
            Offset.lerp(bottomLeft, topLeft, phaseProgress) ?? bottomLeft,
        color:
            Color.lerp(
              widget.phaseTwoColor,
              widget.phaseOneColor,
              phaseProgress,
            ) ??
            widget.phaseTwoColor,
      );
    }

    if (split >= 1) {
      final phaseProgress = widget.curve.transform(rawValue);
      return _FrameData(
        firstOffset: Offset.lerp(topLeft, topRight, phaseProgress) ?? topLeft,
        secondOffset:
            Offset.lerp(bottomRight, bottomLeft, phaseProgress) ?? bottomRight,
        color:
            Color.lerp(
              widget.phaseOneColor,
              widget.phaseTwoColor,
              phaseProgress,
            ) ??
            widget.phaseOneColor,
      );
    }

    if (rawValue < split) {
      final phaseProgress = widget.curve.transform(rawValue / split);
      return _FrameData(
        firstOffset: Offset.lerp(topLeft, topRight, phaseProgress) ?? topLeft,
        secondOffset:
            Offset.lerp(bottomRight, bottomLeft, phaseProgress) ?? bottomRight,
        color:
            Color.lerp(
              widget.phaseOneColor,
              widget.phaseTwoColor,
              phaseProgress,
            ) ??
            widget.phaseOneColor,
      );
    }

    final phaseProgress = widget.curve.transform(
      (rawValue - split) / (1 - split),
    );
    return _FrameData(
      firstOffset:
          Offset.lerp(topRight, bottomRight, phaseProgress) ?? topRight,
      secondOffset:
          Offset.lerp(bottomLeft, topLeft, phaseProgress) ?? bottomLeft,
      color:
          Color.lerp(widget.phaseTwoColor, widget.phaseOneColor, phaseProgress) ??
          widget.phaseTwoColor,
    );
  }
}

class _Square extends StatelessWidget {
  const _Square({
    required this.size,
    required this.radius,
    required this.color,
  });

  final double size;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _FrameData {
  const _FrameData({
    required this.firstOffset,
    required this.secondOffset,
    required this.color,
  });

  final Offset firstOffset;
  final Offset secondOffset;
  final Color color;
}
