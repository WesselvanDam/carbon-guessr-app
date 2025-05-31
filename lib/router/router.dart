import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final initialLocation = ref.watch(initialLocationProvider);

  final router = GoRouter(
    navigatorKey: key,
    initialLocation: initialLocation,
    routes: $appRoutes,
    redirect: redirect,
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404'))),
  );
  ref.onDispose(router.dispose);

  return router;
}

@riverpod
String initialLocation(Ref ref) => '/';

String? redirect(BuildContext context, GoRouterState state) {
  debugPrint('Redirecting to ${state.uri}');
  return null;
}
