import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../data/models/collection.model.dart' show CollectionModel;
import '../../../../data/models/item.model.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/progress_bar.dart';
import '../../collection/providers/current_collection.dart';
import '../../game/controllers/game_controller.dart';
import '../../game/models/game.model.dart';
import '../../game/models/round.model.dart';
import 'local/goal_page.dart';
import 'local/next_button.dart';
import 'local/round_explanation_page.dart';
import 'local/welcome_page.dart';

const pageOneItemA = ItemModel(
  id: 1,
  title: 'Square A',
  description:
      'Congratulations! You have found the description of this item. Once you are playing an actual game, this is where you would find additional information about the item.',
  value: 100,
  quantity: '',
  category: '',
  sources: [],
);

final pageOneItemB = pageOneItemA.copyWith(
  id: 2,
  title: 'Square B',
  value: 200,
);

const pageThreeItemA = ItemModel(
  id: 1,
  title: 'Size of India',
  description: 'The total surface area of India',
  value: 3.29e6,
  quantity: 'km²',
  category: 'Surface Area',
  sources: [],
);

final pageThreeItemB = pageThreeItemA.copyWith(
  id: 2,
  title: 'Size of United States',
  description: 'The total surface area of the United States',
  value: 9.83e6,
);

final game = GameModel(
  rounds: [
    RoundModel(
      correctRatio: pageOneItemA.value / pageOneItemB.value,
      roundNumber: 0,
      itemA: pageOneItemA,
      itemB: pageOneItemB,
    ),
    RoundModel(
      correctRatio: pageThreeItemA.value / pageThreeItemB.value,
      roundNumber: 1,
      itemA: pageThreeItemA,
      itemB: pageThreeItemB,
    ),
  ],
);

const collection = CollectionModel(
  id: 'onboarding',
  lastUpdated: '2024-01-01T00:00:00Z',
  title: 'Onboarding Collection',
  tagline: 'A collection used for onboarding new players',
  description: 'This collection is used to onboard new players to the game.',
  quantity: '',
  unit: '',
  size: 2,
  ratioBoundary: 0.001,
);

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  double _progress = 0;

  final List<Widget> _pages = [
    const WelcomePage(),
    const GoalPage(),
    const RoundExplanationPage(),
  ];

  @override
  void initState() {
    super.initState();
    _progress = 1 / _pages.length;
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
    return ProviderScope(
      overrides: [
        gameControllerProvider.overrideWithBuild((ref, notifier) {
          ref.keepAlive();
          return game;
        }),
        currentCollectionProvider.overrideWith((ref) => collection),
      ],
      child: Scaffold(
        // appBar: AppBar(
        //   children: [
        //     RoundedIconButton(
        //           icon: Symbols.arrow_back,
        //           backgroundColor: Colors.transparent,
        //           onPressed: _progress > 1 / 3
        //               ? () => _pageController.previousPage(
        //                   duration: const Duration(milliseconds: 300),
        //                   curve: Curves.easeInOut,
        //                 )
        //               : null,
        //         )
        //         .animate(target: _progress > 1 / 3 ? 1.0 : 0.0)
        //         .fade(duration: const Duration(milliseconds: 300)),
        //     Expanded(child: ProgressBar(progress: _progress)),
        //     RoundedIconButton(
        //       icon: Symbols.close,
        //       backgroundColor: Colors.transparent,
        //       onPressed: () => context.go(const HomeRoute().location),
        //     ),
        //   ],
        // ),
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
      ),
    );
  }
}
