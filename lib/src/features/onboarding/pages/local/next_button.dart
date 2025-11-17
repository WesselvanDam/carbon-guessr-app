import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../local_storage/local_storage_keys.dart';
import '../../../../../local_storage/local_storage_providers.dart';
import '../../../../../router/routes.dart';
import '../../../game/controllers/ratio_controller.dart';

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

  @override
  void dispose() {
    widget.pageController.removeListener(() {});
    super.dispose();
  }

  void _onFinishOnboarding() {
    ref
        .read(localStorageRepositoryProvider)
        .setBool(LocalStorageBoolKeys.hasSeenOnboarding, true);
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    void toNextPageCallback() {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (_currentPage == 0) {
      return Consumer(
        builder: (context, ref, child) {
          final ratio = ref.watch(ratioControllerProvider);
          final isRatioCorrect = ((1 / ratio) - 2).abs() < 0.005;
          return TextButton(
                onPressed: toNextPageCallback,
                child: const Text('Next'),
              )
              .animate(target: isRatioCorrect ? 1 : 0)
              .fade(duration: 300.ms);
        },
      );
    }

    if (_currentPage == 1) {
      return TextButton(
        onPressed: toNextPageCallback,
        child: const Text('Next'),
      ).animate().fadeIn(duration: 300.ms);
    }

    if (_currentPage == 2) {
      return TextButton(
        onPressed: _onFinishOnboarding,
        child: const Text('Finish'),
      ).animate().fadeIn(duration: 300.ms);
    }

    return const SizedBox.shrink();
  }
}
