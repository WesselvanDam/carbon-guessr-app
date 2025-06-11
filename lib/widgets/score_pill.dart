import 'package:flutter/material.dart';

class ScorePill extends StatelessWidget {
  const ScorePill({
    required this.score,
    required this.style,
    required this.padding,
    super.key,
  });

  final int score;
  final TextStyle style;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (score) {
      < 25 => const Color(0xffffdad3),
      < 50 => const Color(0xffffdcc1),
      < 75 => const Color(0xfff8e287),
      _ => const Color(0xffcdeda3),
    };
    final Color onBackgroundColor = switch (score) {
      < 25 => const Color(0xff733427),
      < 50 => const Color(0xff6b3b04),
      < 75 => const Color(0xff534600),
      _ => const Color(0xff354e16),
    };

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Text(
        score.toString(),
        textAlign: TextAlign.center,
        style: style.copyWith(color: onBackgroundColor),
      ),
    );
  }
}
