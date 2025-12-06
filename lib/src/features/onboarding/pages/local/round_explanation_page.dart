import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/item.model.dart';
import '../../../game/controllers/game_controller.dart';
import '../../../game/controllers/timer_controller.dart';
import '../../../game/models/game.model.dart';
import '../../../game/models/round.model.dart';
import '../../../game/pages/local/custom_ratio_field.dart';
import '../../../game/pages/local/evaluation_row.dart';

class RoundExplanationPage extends StatelessWidget {
  const RoundExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const itemA = ItemModel(
      id: 1,
      title: 'Size of India',
      description: '',
      value: 3.29e6,
      quantity: 'km²',
      category: 'Surface Area',
      sources: [],
    );

    final itemB = itemA.copyWith(
      id: 2,
      title: 'Size of United States',
      value: 9.83e6,
    );

    final round = RoundModel(
      correctRatio: itemA.value / itemB.value,
      roundNumber: 0,
      itemA: itemA,
      itemB: itemB,
    );

    final game = GameModel(rounds: [round]);

    final baseStyle = Theme.of(context).textTheme.bodyLarge!;

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
            Text(
              'Playing A Game',
              style: baseStyle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'When you start a game in a collection, you will encounter five rounds asking you to compare two items.',
              style: baseStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Try it out below by adjusting the squares to represent the size ratio between India and the USA.',
              style: baseStyle,
            ),
            const EvaluationRow(),
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
                            style: baseStyle.copyWith(
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
