import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_shadows.dart';

class Card extends StatelessWidget {
  const Card({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.neutral100),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
