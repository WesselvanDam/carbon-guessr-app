import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/progress_bar.dart';
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
  double _progress = 1 / 4;

  final List<Widget> _pages = [
    const WelcomePage(),
    const GoalPage(),
    const RoundExplanationPage(),
    const LetsStartPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _progress = ((_pageController.page ?? 0) + 1) / (_pages.length);
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        children: [
          RoundedIconButton(
            icon: Symbols.arrow_back,
            backgroundColor: Colors.transparent,
            onPressed: _progress > 1 / 4
                ? () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
                : null,
          ),
          Expanded(child: ProgressBar(progress: _progress)),
          RoundedIconButton(
            icon: Symbols.close,
            backgroundColor: Colors.transparent,
            onPressed: () => context.go(const HomeRoute().location),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: _pages[index],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: NextButton(pageController: _pageController),
          ),
        ],
      ),
    );
  }
}
