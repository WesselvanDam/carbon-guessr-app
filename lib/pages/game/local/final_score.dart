import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CoolScoreWidget extends StatefulWidget {
  const CoolScoreWidget({
    required this.score,
    super.key,
    this.maxScore = 500,
  });

  final int score;
  final int maxScore;

  @override
  State<CoolScoreWidget> createState() => _CoolScoreWidgetState();
}

class _CoolScoreWidgetState extends State<CoolScoreWidget> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color trackColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return Stack(
      alignment: Alignment.center,
      children: [
        // The Solid Color Ring Painter

        // The Animated Score Text
        Animate(
          effects: [
            CustomEffect(
              duration: 2500.ms,
              delay: 100.ms,
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                final displayedScore = (widget.score * value).round();
                final double percent = displayedScore / widget.maxScore;
                return SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: ScoreRingPainter(
                        progress: percent,
                        color: primaryColor,
                        trackColor: trackColor,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$displayedScore',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 88,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'FINAL SCORE',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ],
          onComplete: (controller) {
            if (widget.score > 0) {
              _confettiController.play();
            }
          },
          child: const Text(''),
        ),

        // The Confetti Effect
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiaryContainer,
            ],
          ),
        ),
      ],
    )
        .animate()
        .scale(duration: 1200.ms, delay: 100.ms, curve: Curves.easeOutCubic);
  }
}

// Custom Painter for the animated, glowing, solid color ring
class ScoreRingPainter extends CustomPainter {
  ScoreRingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress; // 0.0 to 1.0
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: size.width / 2 - 20);
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    // Background ring paint
    final backgroundPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Progress ring paint
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Draw the rings
    canvas.drawArc(rect, startAngle, 2 * pi, false, backgroundPaint);
    if (progress > 0) {
      canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
