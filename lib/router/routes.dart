import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/game_mode.dart';
import '../src/features/collection/pages/collection_page.dart';
import '../src/features/game/pages/game_page.dart';
import '../src/features/home/pages/home_page.dart';
import '../src/features/onboarding/pages/onboarding_page.dart';


part 'routes.g.dart';

@TypedShellRoute<ShellRoute>(
  routes: [
    TypedGoRoute<OnboardingRoute>(
      path: '/onboarding',
    ),
    TypedGoRoute<HomeRoute>(
      path: '/',
      routes: [
        TypedGoRoute<CollectionRoute>(
          path: 'collection/:cid',
          routes: [
            TypedGoRoute<GameRoute>(
              path: 'game/:gid',
            ),
          ],
        ),
      ],
    ),
  ],
)
class ShellRoute extends ShellRouteData {
  const ShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget child) {
    return child;
  }
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}

class CollectionRoute extends GoRouteData with $CollectionRoute {
  const CollectionRoute({required this.cid});

  final String cid;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CollectionPage(cid: cid);
  }
}

class GameRoute extends GoRouteData with $GameRoute {
  const GameRoute({required this.cid, required this.gid, required this.mode});

  final String cid;
  final String gid;
  final GameMode mode;

  @override
  Widget build(BuildContext context, GoRouterState state) => const GamePage();
}
