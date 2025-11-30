import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'local/goal_page.dart';
import 'local/lets_start_page.dart';
import 'local/next_button.dart';
import 'local/round_explanation_page.dart';
import 'local/welcome_page.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const WelcomePage(),
    const GoalPage(),
    const RoundExplanationPage(),
    const LetsStartPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              physics: const NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                child: _pages[index],
              ),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: NextButton(pageController: _pageController)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
