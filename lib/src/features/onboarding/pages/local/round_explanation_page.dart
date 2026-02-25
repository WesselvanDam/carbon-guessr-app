import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/item.model.dart';
import '../../../../design_system/components/cards/card.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../game/controllers/game_controller.dart';
import '../../../game/controllers/timer_controller.dart';
import '../../../game/models/game.model.dart';
import '../../../game/models/round.model.dart';
import '../../../game/pages/round_header.dart';
import '../../../game/widgets/custom_ratio_field.dart';

class RoundExplanationPage extends StatelessWidget {
  const RoundExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const itemA = ItemModel(
      id: 1,
      title: 'Size of India',
      description: 'The total surface area of India',
      value: 3.29e6,
      quantity: 'km²',
      category: 'Surface Area',
      sources: [],
    );

    final itemB = itemA.copyWith(
      id: 2,
      title: 'Size of United States',
      description: 'The total surface area of the United States',
      value: 9.83e6,
    );

    final round = RoundModel(
      correctRatio: itemA.value / itemB.value,
      roundNumber: 0,
      itemA: itemA,
      itemB: itemB,
    );

    final game = GameModel(rounds: [round]);

    return ProviderScope(
      overrides: [
        gameControllerProvider.overrideWithBuild((ref, notifier) {
          ref.keepAlive();
          return game;
        }),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            const Text('Make Your Guess', style: AppTypography.h2),
            const Text(
              'Compare two items per round. Lock in your guess to reveal the true scale and get your score.',
              style: AppTypography.h4,
            ),
            const Text(
              'Try it out. Adjust the squares to compare India and the USA, then hit submit!',
              style: AppTypography.bodyLarge,
            ),
            const Card(child: EvaluationRow()),
            const CustomRatioField(),
            Align(
              alignment: .topCenter,
              child: Consumer(
                builder: (context, ref, _) {
                  final hasSubmitted = ref.watch(
                    timerControllerProvider.select((time) => time == 0),
                  );
                  return AnimatedSwitcher(
                    duration: 500.ms,
                    child: hasSubmitted
                        ? Text(
                            key: const ValueKey('explanation_text'),
                            'The closer your estimate is to the true ratio, the higher your score for that round!',
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : FilledButton(
                            key: const ValueKey('submit_button'),
                            onPressed: () => ref
                                .read(gameControllerProvider.notifier)
                                .onSubmit(),
                            child: const Text('Submit Estimate'),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
