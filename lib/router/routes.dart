import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/game/game.model.dart';
import '../pages/collection/collection_page.dart';
import '../pages/game/game_page.dart';
import '../pages/home/homePage.dart';

part 'routes.g.dart';

@TypedShellRoute<ShellRoute>(
  routes: [
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

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class CollectionRoute extends GoRouteData {
  const CollectionRoute({required this.cid});

  final String cid;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CollectionPage(cid: cid);
  }
}

class GameRoute extends GoRouteData {
  const GameRoute({required this.cid, required this.gid, required this.mode});

  final String cid;
  final String gid;
  final GameMode mode;

  @override
  Widget build(BuildContext context, GoRouterState state) => const GamePage();
}
