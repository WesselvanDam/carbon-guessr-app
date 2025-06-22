import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions.dart';
import '../../../widgets/score_pill.dart';
import '../game_controller.dart';
import 'ratio_controller.dart';
import 'timer_controller.dart';

class EvaluationRow extends ConsumerStatefulWidget {
  const EvaluationRow({super.key});

  @override
  ConsumerState<EvaluationRow> createState() => _EvaluationRowState();
}

class _EvaluationRowState extends ConsumerState<EvaluationRow> {
  late final TextEditingController _firstTextController;
  late final TextEditingController _secondTextController;

  @override
  void initState() {
    super.initState();
    final ratio = ref.read(ratioControllerProvider);
    _firstTextController = TextEditingController(
      text: ratio > 1 ? ratio.toStringAsFixed(decimals(ratio)) : '1',
    );
    _secondTextController = TextEditingController(
      text: ratio > 1 ? '1' : (1 / ratio).toStringAsFixed(decimals(1 / ratio)),
    );
  }

  @override
  void dispose() {
    _firstTextController.dispose();
    _secondTextController.dispose();
    super.dispose();
  }

  int decimals(double ratio) {
    if (ratio > 100) return 0;
    if (ratio > 10) return 1;
    return 2;
  }

  void updateControllers(double ratio) {
    // Update the text controllers based on the new ratio

    if (ratio > 1) {
      _firstTextController.text = ratio.toStringAsFixed(decimals(ratio));
      _secondTextController.text = '1';
    } else {
      _firstTextController.text = '1';
      _secondTextController.text =
          (1 / ratio).toStringAsFixed(decimals(1 / ratio));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the text controllers when the ratio changes
    ref.listen(ratioControllerProvider, (_, next) => updateControllers(next));

    final currentRound = ref.watch(gameControllerProvider.select(
      (game) => game.value?.currentRound,
    ));

    final isRoundOver =
        ref.watch(timerControllerProvider.select((time) => time == 0));

    final style = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        );
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isRoundOver && currentRound != null)
            // Show the true ratio if the estimate is submitted
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: RichText(
                      text: currentRound.correctRatio.ratioToReadableTextSpan(
                        style: style,
                        leftDigitStyle: style.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                        rightDigitStyle: style.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ),
                  ),
                  Text(
                    'True ratio'.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isRoundOver ||
                    (isRoundOver && currentRound?.userEstimate != null))
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: RichText(
                      text: TextSpan(
                        style: style,
                        children: [
                          ratioTextField(
                            _firstTextController,
                            style,
                            isSecondField: false,
                            isRoundOver: isRoundOver,
                          ),
                          const TextSpan(text: ' : '),
                          ratioTextField(
                            _secondTextController,
                            style,
                            isSecondField: true,
                            isRoundOver: isRoundOver,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'N/A',
                      style: style.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                Text(
                  'Your guess'.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          if (isRoundOver && currentRound != null)
            // Show the score if the estimate is submitted
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScorePill(
                    score: currentRound.score,
                    style: style,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  ),
                  Text(
                    'Score'.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  WidgetSpan ratioTextField(
    TextEditingController controller,
    TextStyle? style, {
    required bool isSecondField,
    required bool isRoundOver,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: TextField(
        controller: controller,
        enabled: !isRoundOver,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: style?.copyWith(
          color: isSecondField
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
        textAlign: isSecondField ? TextAlign.start : TextAlign.end,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 2, top: 2),
          border: UnderlineInputBorder(),
          constraints: BoxConstraints(maxWidth: 40),
        ),
        onChanged: (value) {
          final ratio = double.tryParse(value);
          if (ratio == null || ratio < 1) return;
          ref
              .read(ratioControllerProvider.notifier)
              .set(isSecondField ? 1 / ratio : ratio);
        },
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
