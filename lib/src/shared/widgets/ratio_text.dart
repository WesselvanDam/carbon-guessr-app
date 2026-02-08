import 'package:flutter/material.dart';
import '../../design_system/styles/app_colors.dart';

class RatioText extends StatelessWidget {
  const RatioText({required this.ratio, super.key, this.style});

  final double ratio;
  final TextStyle? style;

  int _decimals(double ratio) {
    if (ratio > 100) return 0;
    if (ratio > 10) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          TextSpan(
            text: ratio > 1 ? ratio.toStringAsFixed(_decimals(ratio)) : '1',
            style: const TextStyle(color: AppColors.primary600),
          ),
          const TextSpan(
            text: ' : ',
            style: TextStyle(color: AppColors.neutral300),
          ),
          TextSpan(
            text: ratio >= 1
                ? '1'
                : (1 / ratio).toStringAsFixed(_decimals(1 / ratio)),
            style: const TextStyle(color: AppColors.accent600),
          ),
        ],
      ),
    );
  }
}
