import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game/game.model.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/score_pill.dart';
import '../game_controller.dart';
import 'custom_ratio_field.dart';
import 'game_intro.dart';
import 'item_card.dart';
import 'ratio_controller.dart';
import 'timer_controller.dart';

class GameRoundForm extends ConsumerStatefulWidget {
  const GameRoundForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundFormState();
}

class _GameRoundFormState extends ConsumerState<GameRoundForm> {
  late final TextEditingController _firstTextController;
  late final TextEditingController _secondTextController;
  bool _isSubmitted = false;

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
    // Reset the ratio controller when the form is initialized
    ref.listen(ratioControllerProvider, (_, next) => updateControllers(next));

    // Flip the submitted switch if the time is up and the form is not submitted
    ref.listen(timerControllerProvider, (_, next) {
      if (next == 0 && !_isSubmitted) {
        setState(() => _isSubmitted = true);
      }
    });

    final game = ref.watch(gameControllerProvider).value;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GameIntro(),
          const SizedBox(height: 16),
          const IntrinsicHeight(
            child: Row(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ItemCard.first()),
                Expanded(child: ItemCard.second()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildEstimateRow(game),
          const SizedBox(height: 16),
          const CustomRatioField(),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: _isSubmitted ? _nextRound : _submitEstimate,
              icon: Icon(_isSubmitted ? Icons.arrow_forward : Icons.check),
              label: Text(_isSubmitted ? 'Next Round' : 'Submit Estimate'),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the row displaying the estimated ratio and the true ratio if submitted.
  Widget _buildEstimateRow(GameModel? game) {
    final style = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        );
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        ),
                        const TextSpan(text: ' : '),
                        ratioTextField(
                          _secondTextController,
                          style,
                          isSecondField: true,
                        ),
                      ],
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
          if (_isSubmitted)
            // Show the true ratio if the estimate is submitted
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: RichText(
                      text: game!.currentRound.correctRatio
                          .ratioToReadableTextSpan(
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
          if (_isSubmitted)
            // Show the score if the estimate is submitted
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScorePill(
                    score: game!.currentRound.score,
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
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: TextField(
        controller: controller,
        enabled: !_isSubmitted,
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

  void _submitEstimate() {
    try {
      ref.read(gameControllerProvider.notifier).onSubmit();

      // Update UI to show results
      setState(() {
        _isSubmitted = true;
      });
    } catch (e) {
      debugPrint('Error submitting estimate: $e');
      debugPrintStack(label: 'Stack trace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  void _nextRound() {
    setState(() {
      _isSubmitted = false;
      ref.read(ratioControllerProvider.notifier).reset();
    });

    ref.read(gameControllerProvider.notifier).onNextRound();
  }
}
