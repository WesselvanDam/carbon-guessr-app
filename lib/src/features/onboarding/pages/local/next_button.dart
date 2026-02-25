import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/buttons/action_button.dart';
import '../../../game/controllers/game_controller.dart';
import '../../../game/controllers/ratio_controller.dart';
import '../../../game/widgets/submit_button.dart';

class NextButton extends ConsumerStatefulWidget {
  const NextButton({required this.pageController, super.key});

  final PageController pageController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NextButtonState();
}

class _NextButtonState extends ConsumerState<NextButton> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      final newPage = widget.pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  void _toNextPageCallback() {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void Function()? _callBackForCurrentPage() {
    if (_currentPage == 0) {
      // Disable the button until the correct ratio is achieved. 
      final ratio = ref.watch(ratioControllerProvider);
      final isRatioCorrect = ((1 / ratio) - 2).abs() < 0.02;
      return isRatioCorrect ? _toNextPageCallback : null;
    }

    if (_currentPage == 1) {
      // Cycle the game to the next round, then navigate to the next page.
      void nextRoundAndNavigate() {
        ref.read(gameControllerProvider.notifier).onNextRound();
        _toNextPageCallback();
      }

      return nextRoundAndNavigate;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPage == 2) {
      // On the last page, we show the generic game Submit Button.
      return const SubmitButton(lastRoundText: "Let's Go!",);
    }

    final callBackForCurrentPage = _callBackForCurrentPage();

    return ActionButton.primary(
      onPressed: callBackForCurrentPage,
      label: _currentPage == 3 ? "LET'S GO!" : 'NEXT',
      fullWidth: true,
      showArrow: true,
    ).animate().fadeIn(duration: 300.ms);
  }
}
