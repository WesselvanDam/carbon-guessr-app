import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/item.model.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../game/controllers/game_controller.dart';
import '../../../game/controllers/ratio_controller.dart';
import '../../../game/models/game.model.dart';
import '../../../game/models/round.model.dart';
import '../../../game/pages/local/custom_ratio_field.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const baseItem = ItemModel(
      id: 1,
      title: 'Square A',
      description: 'This is a sample item used in onboarding.',
      value: 100,
      quantity: 'Units',
      category: 'Sample Category',
      sources: [],
    );

    final round = RoundModel(
      correctRatio: 2,
      roundNumber: 0,
      itemA: baseItem,
      itemB: baseItem.copyWith(id: 2, title: 'Square B', value: 200),
    );

    final game = GameModel(rounds: [round]);

    final baseStyle = Theme.of(context).textTheme.bodyLarge!;

    return ProviderScope(
      overrides: [
        gameControllerProvider.overrideWithBuild((ref, notifier) => game),
      ],
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Text(
              'Welcome to Quoscient!',
              style: baseStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'To continue, pinch the squares until square B is twice the size of square A.',
              style: baseStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const CustomRatioField(),
            Consumer(
              builder: (context, ref, child) {
                final ratio = ref.watch(ratioControllerProvider);
                debugPrint('Current ratio: $ratio');
                final style = Theme.of(context).textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold);
                return Column(
                  spacing: 8,
                  children: [
                    Text(
                      'Ratio between the sizes of both squares:',
                      style: baseStyle,
                      textAlign: TextAlign.center,
                    ),
                    RichText(
                      text: ratio.ratioToReadableTextSpan(
                        style: style,
                        leftDigitStyle: style.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        rightDigitStyle: style.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    Text(
                      '"Square B is ${(1 / ratio).toStringAsFixed(2)} times the size of Square A"',
                      style: baseStyle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
