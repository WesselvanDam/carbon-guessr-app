import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../router/routes.dart';
import '../../services/local_storage/local_storage_keys.dart';
import '../../services/local_storage/local_storage_providers.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    Center(
      child: Text('Welcome to Carbon Guessr!', style: TextStyle(fontSize: 24)),
    ),
    Center(child: Text('Learn how to play.', style: TextStyle(fontSize: 24))),
    Center(child: Text('Ready to start?', style: TextStyle(fontSize: 24))),
  ];

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onFinishOnboarding() {
    try {
      ref
          .read(localStorageRepositoryProvider)
          .setBool(LocalStorageBoolKeys.hasSeenOnboarding, true);
      if (context.mounted) {
        const HomeRoute().go(context);
      }
    } catch (e, stack) {
      debugPrint('Error finishing onboarding: $e\n$stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => _pages[index],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: SizedBox.shrink()),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: _pages.length,
                        effect: CustomizableEffect(
                          activeDotDecoration: DotDecoration(
                            width: 16,
                            height: 16,
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          dotDecoration: DotDecoration(
                            width: 12,
                            height: 12,
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_currentPage == _pages.length - 1)
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: _onFinishOnboarding,
                        child: const Text('Finish'),
                      ),
                    ),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
