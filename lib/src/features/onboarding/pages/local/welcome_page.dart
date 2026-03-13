import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/cards/card.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../../shared/widgets/ratio_text.dart';
import '../../../game/controllers/ratio_controller.dart';
import '../../../game/widgets/custom_ratio_field.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        const SizedBox(height: 24),
        const Text('Welcome To Quoscient!', style: AppTypography.h2),
        const Text(
          'To continue, pinch the squares until square B is twice the size of square A.',
          style: AppTypography.h4,
        ),
        const Spacer(),
        Card(
          child: Consumer(
            builder: (context, ref, child) {
              final ratio = ref.watch(ratioControllerProvider);
              return Column(
                children: [
                  Text(
                    'Ratio between the sizes of both squares'.toUpperCase(),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.neutral400,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatioText(
                    ratio: ratio,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const CustomRatioField(),
      ],
    );
  }
}
