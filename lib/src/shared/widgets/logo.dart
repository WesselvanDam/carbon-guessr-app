import 'package:flutter/material.dart';

/// A custom painter that renders the Carbon Guessr logo as a geometric shape.
///
/// The logo consists of:
/// 1. A blue rounded border made from a rounded rectangle with a rounded rectangular cutout
/// 2. Two orange squares in the cutout area
///
/// Corner radii:
/// - Outer corners (logo edges): 1/8 of canvas size
/// - Inner corners (cutout edges): 1/16 of canvas size
class LogoPainter extends CustomPainter {
  static const Color _blueColor = Color(0xFF1a83af);
  static const Color _orangeColor = Color(0xFFdf5e17);

  @override
  void paint(Canvas canvas, Size size) {
    final logoSize = size.shortestSide;
    final scale = logoSize / 512.0;
    final dx = (size.width - logoSize) / 2;
    final dy = (size.height - logoSize) / 2;

    final bluePaint = Paint()
      ..color = _blueColor
      ..style = PaintingStyle.fill;

    final orangePaint = Paint()
      ..color = _orangeColor
      ..style = PaintingStyle.fill;

    final bluePath = _buildBluePath(scale, dx, dy);
    final orangeCenterPath = _buildOrangeCenterPath(scale, dx, dy);
    final orangeCornerPath = _buildOrangeCornerPath(scale, dx, dy);

    canvas.drawPath(bluePath, bluePaint);
    canvas.drawPath(orangeCenterPath, orangePaint);
    canvas.drawPath(orangeCornerPath, orangePaint);
  }

  Path _buildBluePath(double s, double dx, double dy) {
    double x(double v) => dx + v * s;
    double y(double v) => dy + v * s;

    return Path()
      ..moveTo(x(512), y(64))
      ..relativeLineTo(0, 176 * s)
      ..relativeCubicTo(0, 8.8366 * s, -7.1634 * s, 16 * s, -16 * s, 16 * s)
      ..relativeLineTo(-96 * s, 0)
      ..relativeCubicTo(-8.8366 * s, 0, -16 * s, -7.1634 * s, -16 * s, -16 * s)
      ..relativeLineTo(0, -80 * s)
      ..relativeCubicTo(
        0,
        -17.6731 * s,
        -14.3269 * s,
        -32 * s,
        -32 * s,
        -32 * s,
      )
      ..relativeLineTo(-192 * s, 0)
      ..relativeCubicTo(-17.6731 * s, 0, -32 * s, 14.3269 * s, -32 * s, 32 * s)
      ..relativeLineTo(0, 192 * s)
      ..relativeCubicTo(0, 17.6731 * s, 14.3269 * s, 32 * s, 32 * s, 32 * s)
      ..relativeLineTo(80 * s, 0)
      ..relativeCubicTo(8.8366 * s, 0, 16 * s, 7.1634 * s, 16 * s, 16 * s)
      ..relativeLineTo(0, 96 * s)
      ..relativeCubicTo(0, 8.8366 * s, -7.1634 * s, 16 * s, -16 * s, 16 * s)
      ..lineTo(x(64), y(512))
      ..relativeCubicTo(
        -35.3462 * s,
        0,
        -64 * s,
        -28.6538 * s,
        -64 * s,
        -64 * s,
      )
      ..lineTo(x(0), y(64))
      ..cubicTo(x(0), y(28.6538), x(28.6538), y(0), x(64), y(0))
      ..relativeLineTo(384 * s, 0)
      ..relativeCubicTo(35.3462 * s, 0, 64 * s, 28.6538 * s, 64 * s, 64 * s)
      ..close();
  }

  Path _buildOrangeCenterPath(double s, double dx, double dy) {
    double x(double v) => dx + v * s;
    double y(double v) => dy + v * s;

    return Path()
      ..moveTo(x(384), y(272))
      ..relativeLineTo(0, 96 * s)
      ..relativeCubicTo(0, 8.8366 * s, -7.1634 * s, 16 * s, -16 * s, 16 * s)
      ..relativeLineTo(-96 * s, 0)
      ..relativeCubicTo(-8.8366 * s, 0, -16 * s, -7.1634 * s, -16 * s, -16 * s)
      ..relativeLineTo(0, -80 * s)
      ..relativeCubicTo(0, -17.6731 * s, 14.3269 * s, -32 * s, 32 * s, -32 * s)
      ..relativeLineTo(80 * s, 0)
      ..relativeCubicTo(8.8366 * s, 0, 16 * s, 7.1634 * s, 16 * s, 16 * s)
      ..close();
  }

  Path _buildOrangeCornerPath(double s, double dx, double dy) {
    double x(double v) => dx + v * s;
    double y(double v) => dy + v * s;

    return Path()
      ..moveTo(x(512), y(400))
      ..relativeLineTo(0, 48 * s)
      ..relativeCubicTo(0, 35.3462 * s, -28.6538 * s, 64 * s, -64 * s, 64 * s)
      ..relativeLineTo(-48 * s, 0)
      ..relativeCubicTo(-8.8366 * s, 0, -16 * s, -7.1634 * s, -16 * s, -16 * s)
      ..relativeLineTo(0, -96 * s)
      ..relativeCubicTo(0, -8.8366 * s, 7.1634 * s, -16 * s, 16 * s, -16 * s)
      ..relativeLineTo(96 * s, 0)
      ..relativeCubicTo(8.8366 * s, 0, 16 * s, 7.1634 * s, 16 * s, 16 * s)
      ..close();
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) => false;
}

/// A widget that displays the Carbon Guessr logo, filling its parent constraints.
class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LogoPainter(), child: const SizedBox.expand());
  }
}
