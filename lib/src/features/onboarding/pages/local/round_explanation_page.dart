import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../local_storage/local_storage_keys.dart';
import '../../../../../local_storage/local_storage_repository.dart';
import '../../../../../router/routes.dart';
import '../../../../design_system/components/cards/card.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../game/controllers/game_controller.dart';
import '../../../game/pages/round_header.dart';
import '../../../game/widgets/custom_ratio_field.dart';

class RoundExplanationPage extends ConsumerWidget {
  const RoundExplanationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(gameControllerProvider, (previous, next) {
      if (next.value?.isCompleted ?? false) {
        // Onboarding is completed, set the flag in local storage
        ref
            .read(localStorageRepositoryProvider)
            .setBool(LocalStorageBoolKeys.hasSeenOnboarding, true);
        // Navigate to the home page
        const HomeRoute().go(context);
      }
    });

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Text('Make Your Guess', style: AppTypography.h2),
        Text(
          'Compare two items per round. Lock in your guess to reveal the true scale and get your score.',
          style: AppTypography.h4,
        ),
        Text(
          'Try it out. Adjust the squares to compare India and the USA, then hit submit and check your score!',
          style: AppTypography.bodyLarge,
        ),
        Card(child: EvaluationRow()),
        CustomRatioField(),
      ],
    );
  }
}
