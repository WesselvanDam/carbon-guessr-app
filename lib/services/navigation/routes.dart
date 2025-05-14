import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/home/homePage.dart';

part 'routes.g.dart';

@TypedShellRoute<ShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: '/',
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
