import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/game/game_session.dart';
import '../../pages/collection/collection_detail_page.dart';
import '../../pages/collection/collection_list_page.dart';
import '../../pages/game/game_mode_selection_page.dart';
import '../../pages/game/game_results_page.dart';
import '../../pages/game/game_round_page.dart';
import '../../pages/home/homePage.dart';

part 'routes.g.dart';

@TypedShellRoute<ShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: '/',
      routes: [
        TypedGoRoute<CollectionListRoute>(
          path: 'collection',
          routes: [
            TypedGoRoute<CollectionDetailRoute>(
              path: 'collection/:id',
            ),
          ],
        ),
        TypedGoRoute<GameModeSelectionRoute>(
          path: 'game',
          routes: [
            TypedGoRoute<GameRoundRoute>(
              path: 'round',
            ),
            TypedGoRoute<GameResultsRoute>(
              path: 'results',
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

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class CollectionListRoute extends GoRouteData {
  const CollectionListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CollectionListPage();
  }
}

class CollectionDetailRoute extends GoRouteData {
  const CollectionDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Converting string id to int for the CollectionDetailPage
    final itemId = int.parse(id);
    return CollectionDetailPage(id: itemId);
  }
}

// Add implementations for game routes

class GameModeSelectionRoute extends GoRouteData {
  const GameModeSelectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameModeSelectionPage();
  }
}

class GameRoundRoute extends GoRouteData {
  const GameRoundRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameRoundPage();
  }
}

class GameResultsRoute extends GoRouteData {
  const GameResultsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameResultsPage();
  }
}

/// Named routes for use with Navigator
class AppRoutes {
  static const home = '/';
  static const collectionList = '/collection';
  static const collectionItemDetail = '/collection/:id';
}
