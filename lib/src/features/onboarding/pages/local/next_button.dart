import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../local_storage/local_storage_keys.dart';
import '../../../../../local_storage/local_storage_repository.dart';
import '../../../../../router/routes.dart';
import '../../../../design_system/components/buttons/action_button.dart';
import '../../../game/controllers/ratio_controller.dart';
import '../../../game/controllers/timer_controller.dart';
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

  void _onFinishOnboarding() {
    ref
        .read(localStorageRepositoryProvider)
        .setBool(LocalStorageBoolKeys.hasSeenOnboarding, true);
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }

  void Function()? _callBackForCurrentPage() {
    if (_currentPage == 0) {
      final ratio = ref.watch(ratioControllerProvider);
      final isRatioCorrect = ((1 / ratio) - 2).abs() < 0.02;
      return isRatioCorrect ? _toNextPageCallback : null;
    }

    if (_currentPage == 1) {
      return _toNextPageCallback;
    }

    if (_currentPage == 2) {
      final hasSubmitted = ref.watch(
        timerControllerProvider.select((timer) => timer == 0),
      );
      return hasSubmitted ? _toNextPageCallback : null;
    }

    if (_currentPage == 3) {
      return _onFinishOnboarding;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final callBackForCurrentPage = _callBackForCurrentPage();

    if (_currentPage == 2) {
      return const SubmitButton();
    }

    return ActionButton.primary(
      onPressed: callBackForCurrentPage,
      label: _currentPage == 3 ? "LET'S GO!" : 'NEXT',
      fullWidth: true,
      showArrow: true,
    ).animate().fadeIn(duration: 300.ms);
  }
}
