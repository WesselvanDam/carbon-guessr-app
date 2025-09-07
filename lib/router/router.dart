import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/local_storage/local_storage_keys.dart';
import '../services/local_storage/local_storage_providers.dart';
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
    redirect: (context, state) => redirect(ref, context, state),
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404'))),
  );

  ref.onDispose(router.dispose);

  return router;
}

@riverpod
String initialLocation(Ref ref) {
  final hasSeenOnboarding =
      ref.read(
        localStorageBoolProvider(LocalStorageBoolKeys.hasSeenOnboarding),
      ) ??
      false;
  return hasSeenOnboarding ? '/' : '/onboarding';
}

Future<String?> redirect(
  Ref ref,
  BuildContext context,
  GoRouterState state,
) async {
  debugPrint('Redirecting to [32m${state.uri}[0m');

  return null;
}
