import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_controller.dart';
import 'timer_controller.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  void _submitEstimate(WidgetRef ref) {
    ref.read(gameControllerProvider.notifier).onSubmit();
  }

  void _nextRound(WidgetRef ref) {
    ref.read(gameControllerProvider.notifier).onNextRound();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRoundOver =
        ref.watch(timerControllerProvider.select((state) => state == 0));
    final isLastRound = ref.watch(gameControllerProvider.select((state) =>
        state.value?.currentRoundIndex ==
        (state.value?.rounds.length ?? 0) - 1));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      transitionBuilder: (child, animation) {
        final fromLeft = Tween<Offset>(
          begin: const Offset(-0.6, 0),
          end: Offset.zero,
        ).animate(animation);
        final fromRight = Tween<Offset>(
          begin: const Offset(0.6, 0),
          end: Offset.zero,
        ).animate(animation);

        // Whether this child is entering or exiting
        final isEntering = animation.status == AnimationStatus.forward ||
            animation.status == AnimationStatus.completed;

        // Fade out the disappearing button to the right
        // Fade in the appearing button from the left
        return SlideTransition(
          position: isEntering ? fromRight : fromLeft,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.centerRight,
        children: [
          ...previousChildren,
          currentChild!,
        ],
      ),
      child: isRoundOver
          ? FilledButton.icon(
              key: const ValueKey('next'),
              onPressed: () => _nextRound(ref),
              icon: const Icon(Icons.arrow_forward),
              label: Text(isLastRound ? 'Finish Game' : 'Next Round'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
            )
          : FilledButton.icon(
              key: const ValueKey('submit'),
              onPressed: () => _submitEstimate(ref),
              icon: const Icon(Icons.check),
              label: const Text('Submit Estimate'),
            ),
    );
  }
}
