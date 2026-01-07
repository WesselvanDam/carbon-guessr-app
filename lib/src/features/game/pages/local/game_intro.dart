import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../../collection/providers/current_collection.dart';

class GameIntro extends ConsumerWidget {
  const GameIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Compare the Footprint',
          style: AppTypography.h3.copyWith(
            color: AppColors.text,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Drag the blue square to estimate how many times more ${collection?.quantity ?? 'CO2eq'} one item produces compared to the other.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
